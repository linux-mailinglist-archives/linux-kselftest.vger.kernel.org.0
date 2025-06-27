Return-Path: <linux-kselftest+bounces-35991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F208EAEBEAA
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 19:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F182189F8F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C1C2EB5D8;
	Fri, 27 Jun 2025 17:55:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD02EA148;
	Fri, 27 Jun 2025 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046955; cv=none; b=QJAL10KH+2tdjNDGJIXSsGKscIk28gtEyJeBKC1z3nmfeXEhFPE2Nl3aE5Ml83W61jqbk6IQin87qLoAZ75Z493MgGldpnReiCkjR/Z4IXLts0aAZ5q59Ew4CfmkLxEdrRROXCFJyqX+Z1wCKB3IytumkBLOFGNQtnhe0sb4cuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046955; c=relaxed/simple;
	bh=YQDmW0AHOMU3s6GZ1mdIC4hsmUz01ytmXUBgVV3yg+c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hn9qn7CqVn+jC3LIX00o1zFFbRWL6dIkQ+NyO5DFHLLl3/CpMEx58wdRp3e78OAlktUUi2H0l8hv4g2ot9eNOi2kBX5qGiLUMHYcscPzw3C/FYQynuP2+TtaJkaXTCFWxbxUTd/oLJa2TCyZlFjuYU0rWM4kRokHUihmFBWz/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0b6532345so663410666b.1;
        Fri, 27 Jun 2025 10:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751046952; x=1751651752;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41QiIv+uFhnnf5jTOH3MwkOz5Uie3N60jNO94UEkVlM=;
        b=WM8CMefuiyYaG9IDA0ljTt5MlA4h1PLer6uoYGXeZINYv1FQQ3ZD/a1fm5+0r7lZRj
         V19YljGCcyZJZyaQfP3Nh6ABolsIHuSB8ypdufqiGCZew24LEynL+Yxw95HlY+s3cIXC
         BVfttsb0LKWhwqoue1UAbtfSGZzXCq4c83LhwNZrFuTXc4C/g0WKz7hurEadewx8bFz6
         o1KE/RmQ5HbTFFhiaL+0gWGeGjnf8d9xvysh4/WWfWDnEes3cH19W7o4BG15ooPzf+lH
         /GEEjSTMOV3OcPhpQbseWnoE3eT1vNk8ytyTnycZqgHwC/+Yh9gI6dH5jkvX89TZ8SnM
         SzTw==
X-Forwarded-Encrypted: i=1; AJvYcCVcCiKjTCXrqJrg2/6D4lmE64K1aJadfXemvw+HPpar9WkbMx+mxEG4EsysTE3KfnfQwaPYDt61Fk5VjFjaVSpi@vger.kernel.org, AJvYcCX+wFizyYB2eOhnGdxCr6RGo2mmExn6porYwi6GlnR31MXJuhgsQzE6auJVor045qRRFF9NlHbcf/3C0Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfAsC2ijgXUOc7ILp3Pm6trVdSjuYy2pLMjt5NKEEfcuTfDNjM
	fYjvAmHC6mG2f69UvqvKVpUnyQovFNf48jbT2HalC9fY+zR7DVVSasoC
X-Gm-Gg: ASbGncvox2HeQ3Vij3zYEKF01H3IS/7vUgelYILjp8J4MBLAk5xL1bGPssIBRdDkjL3
	jnT6wvJQGi1yNOHR0FsGcPq2kVAmWirg1gVe58LsuXVCLz6v6W62WLiMkU8yDMddMUAslsIIW4k
	9+KC8SklVJYD/l0XuFuhHF6JmMI+8zKtfZ84nTFfX4nvFhrKiRYjyqPTU9P0S6VAYS/xVEgzdI9
	nsaY0d5n5kop4wFSiKOUD25qRzrL+//gdqP3wYiPJKtgVxy8FoySeDvNMEQ9teKWrB/ywouw4SS
	znMjO4r2UFYzgyz0zd782C1Nl9XMK+3jznBLzdFksPLMfxaVYCLmXg==
X-Google-Smtp-Source: AGHT+IE2/uolgPkUBId7WzzJ21Ck8sXguq+OetxpuidJMY5Mc9L6a6CX3gE2vD+RNH8nPcn4j1Un3g==
X-Received: by 2002:a17:907:6ea9:b0:ae0:b8c5:6142 with SMTP id a640c23a62f3a-ae0d25757b5mr922173666b.7.1751046951550;
        Fri, 27 Jun 2025 10:55:51 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8290ffb4sm1765078a12.36.2025.06.27.10.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:55:50 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/7] netpoll: Factor out functions from
 netpoll_send_udp() and add ipv6 selftest
Date: Fri, 27 Jun 2025 10:55:46 -0700
Message-Id: <20250627-netpoll_untagle_ip-v1-0-61a21692f84a@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACLbXmgC/x3MUQqDMBAFwKss79tAmqKSXKUUCXZrF8IaklgE8
 e6Cc4A5ULkIVwQ6UPgvVVZFoEdHmH9RFzbyQSA463o7OGuUW15TmjZtcUk8STb8HOfR+zh416M
 j5MJf2e/0BeVmlPeG93ledyzQ3G4AAAA=
X-Change-ID: 20250620-netpoll_untagle_ip-e37c799a6925
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2128; i=leitao@debian.org;
 h=from:subject:message-id; bh=YQDmW0AHOMU3s6GZ1mdIC4hsmUz01ytmXUBgVV3yg+c=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoXtsl85gL84npdpHQF18rMWKqLo+yjnoSF8sbP
 yDySTcPtxuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaF7bJQAKCRA1o5Of/Hh3
 bRbRD/4+tckhsv/5F4eHqSbuxkGL80BXgeOeDewEIwJgrDlJhLUPfZJsmnYgURKvdfLUA0UG+b6
 Cbf5umMkqpp3LGYRxWwZ6yJZKoN5mUvGXqnQa32gpEamG31eilyQKYpSU1iYz+mDfmkD6H1UroY
 u2ZDtV5M62CHLqRocBVmX1xZDUEywO09a5yMpQp9iBzfQ4mL3K9EOfF9jeJa0zgjoEbn2J5YEDY
 iMjmdJ6Fw+xsgkC0jqGfnNPv6CQmWJQ+IKD0pppDj8/pka5LD8x2Ie/IdBj/VGNHoTpUrkVAudn
 gZto+K+2tf9/2s52erGrKz7WBd1GJmi3DFtcKUJsSgkQHoF1spYLGmOfHcWq25dPSkd/E+Ora0q
 6W6Em8h1zxGeah+ZewRPcBIoFCF4kQtcSlwyLQe1GAz1/spWPIjBJWnrqjQpOYK5fr3yFLUtcED
 j5ug0WfwunDh5dbcgsckTFEBWivv89dvw0avJKo45QFeBFG02Di25sZ2znrwDjDlRBvyuGTXbCq
 dxUK02BLYds3C+YY94YN7SyPWdkC2vjfevIsqJl9MbAGBrcsufE912lkTHEuBoh6gAmlv0m8hEz
 3V14mEJtVqjXda5AxCmlggPdv4ck9ZsXrcMEXhuJg8fOKaEqFsly3xUOaj9+aQxLTqQCLdEF6Vh
 DAxaVAPSq3M2weg==
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
Breno Leitao (7):
      netpoll: Improve code clarity with explicit struct size calculations
      netpoll: factor out UDP checksum calculation into helper
      netpoll: factor out IPv6 header setup into push_ipv6() helper
      netpoll: factor out IPv4 header setup into push_ipv4() helper
      netpoll: factor out UDP header setup into push_udp() helper
      netpoll: move Ethernet setup to push_eth() helper
      selftests: net: Add IPv6 support to netconsole basic tests

 net/core/netpoll.c                                 | 196 +++++++++++++--------
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  74 +++++++-
 .../testing/selftests/drivers/net/netcons_basic.sh |  52 +++---
 3 files changed, 216 insertions(+), 106 deletions(-)
---
base-commit: 8efa26fcbf8a7f783fd1ce7dd2a409e9b7758df0
change-id: 20250620-netpoll_untagle_ip-e37c799a6925

Best regards,
--  
Breno Leitao <leitao@debian.org>


