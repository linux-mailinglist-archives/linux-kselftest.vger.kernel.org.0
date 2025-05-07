Return-Path: <linux-kselftest+bounces-32571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D25AAE083
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 15:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727503B23D0
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 13:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BFB288C3E;
	Wed,  7 May 2025 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeWTLzXP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56911287508;
	Wed,  7 May 2025 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623951; cv=none; b=b33Ixd8I+FkFse5Quvj/pOREP+EbHGfRT5rLZ9uEome5481ODXcxfThvJVxSI3KDsnVOv0Ra2WFOKUpLgMwpKqSYFzVsxLBcdx9e8X9ZqgB8yp+ATvRFOFbVWQCWy2c+dodQD55V639dwoI2Z/eof15wXMDJ3S65GQ+5LhiYzC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623951; c=relaxed/simple;
	bh=GZkfUCb90AwgYTu3CF2nfh0Om+zRBKE64m3kyCgtnvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJb98D2S0ZvlVeLNXyDuvdfcxUXYZkqjbk9uS1DOfKFD3dswjAgyS0dvLqy628HwImVG6yBpch+OiLVrXdtBfTwtbD4OVi7Cq8eeYn3MH7PtmkDmJ9COQuOSegZUE4gJp2H6T5/IEEWsPvYvm2eZIV9VeLt+Ojzh4Jt7+jfyftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeWTLzXP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22e45088d6eso25796225ad.0;
        Wed, 07 May 2025 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746623949; x=1747228749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/0+7hj5vfYYCIfikC10U5TKg0ZgYAqvVLBu9ngisEFU=;
        b=CeWTLzXPOjIYZm1RZNXE/FMtO7W9DAHOHUcNLYBUKd6lcLfIwWGj1biRtO2PRD2y3i
         NuQnUIyCy//mF9CEsybFyK8V6NgZ4sdGMV2IzsV1dQWtFMMfeARwIjJDmzyFv69fqP0F
         4ZZykmk0plvgvLku7MWANzVPjHrIhxshyLeNIK6g+qroX+/IdiVzDUaViD9O8Oc8PT6e
         B73ZSG5KNrW8qADEZt0pBa6cCgSboFUdB54Mt82XVZDISWDJY2oQSVyyqTXHkL8b5nJs
         StmriapsypN8V1RZ9dkDdoGqwo5tnC17OqtILZgh/aCBMRGj4g7p4YhS7LNa86b6hVMK
         ushA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623949; x=1747228749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0+7hj5vfYYCIfikC10U5TKg0ZgYAqvVLBu9ngisEFU=;
        b=MDVs0Ftnjc8zOXRZZ0kXnYd7qM2XseNOPDqM4mGETtvkZadZUaqQmVYbJlLiCFQa99
         eew1EriMexMNG/ArCBc4axrbRIqhOZw+VrTLH0IJRDi/qoeY+D+y1QbMXSFWbfUhALpd
         kDqPP7ryjHlQ4UB9iJQszonxgr72XNWaouzM6nKfSpejjSWuuK90juuKZz0I3DXqfNG3
         tkwzPyki1krWiy3lHJUJgKwauW4LrgpS4t3sd1i8efWRRnnqkrM71p82W92VqDCd3cP+
         sfgZcgY7B4vmoqxb3x1TP8Bgn/GBw4zTne0EmijUv2C5eWZZWb8cra8k7wbalkjLbxgD
         jNJA==
X-Forwarded-Encrypted: i=1; AJvYcCULLAvr/LzxS2/lij7YmD6mSbMtoCc5BKTVKINMHNAQ529cX5o1b+xjaxSgatZO4/DIg64p2xWQMtcvW5bCgqY=@vger.kernel.org, AJvYcCX4/zFzOU0mQB34JKMMMu+YJY1B6bUUrMJxoNcYYD9awkCWp0yikvWj9IWHMs8lzixZsIB9d8pOm8E9MAVhN9dd@vger.kernel.org
X-Gm-Message-State: AOJu0YwAiTSF2CTsQYuwCN42M/QRKQsuZOQNsag0Lwq0kfQdMCWp41v8
	wP+O9P92TGzBOXzFZMxR/bgPWAnxzZPtrXuuJKlJ93B9Jmqh0FqbvEXfrI/I
X-Gm-Gg: ASbGnct3cFxERhThWycbT7bWyjgcLA4plZ8RArMNaAl3BP9cCDE2osxzclDCuA7NDMo
	S7ZEGs/wZcZpRq/PoWnlp5qabPCxmP4Rqn/aGwl70ya28PWu6/1tiKzDvX8SK7e+wr2HZrHHYfk
	eontBGai72JInNNkM0nxcJe9JeBqRcZxaMaUPcBReNcGuUFJxTX74ywXGoaCFGXwE9XX/nHC9au
	UoJbHoKKMit/+eackDguitNdFWIbQUxvs+NeO/OdRRYuhmPkbrLG+Nkro+tF7HpCqw6znZJWeYA
	3uIDaHqMcpPGNDurCLY1O2vJygDGpWA0LbV4djjPGYz7IsCufKQJCCAOfzJf
X-Google-Smtp-Source: AGHT+IE3aXmNIXQtf4fL4/bp0RdlV5edrxeN1OA2BlzBfH+4n8c0fY1fUmHLL8nXNuECNV+ySfcqKQ==
X-Received: by 2002:a17:902:e38a:b0:22e:62c3:6990 with SMTP id d9443c01a7336-22e62c36999mr30258795ad.16.1746623949214;
        Wed, 07 May 2025 06:19:09 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e5e93ee88sm17414765ad.86.2025.05.07.06.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:19:08 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/6] selftests: net: configure rp_filter in setup_ns
Date: Wed,  7 May 2025 13:18:50 +0000
Message-ID: <20250507131856.78393-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some distributions enable rp_filter globally by default, which can interfere
with various test cases. To address this, many tests explicitly disable
rp_filter within their scripts.

To avoid duplication and ensure consistent behavior across tests, this patch
moves the rp_filter configuration into setup_ns, applied immediately after a
new namespace is created. This change ensures that all namespace-based tests
inherit the appropriate rp_filter settings, simplifying individual test
scripts and improving maintainability.

BTW, the patch 4/6 for srv6 is a bit large. Please tell me if you think
I need to break this one.

Hangbin Liu (6):
  selftests: net: disable rp_filter after namespace initialization
  selftests: net: remove redundant rp_filter configuration
  selftests: net: use setup_ns for bareudp testing
  selftests: net: use setup_ns for SRv6 tests and remove rp_filter
    configuration
  selftests: netfilter: remove rp_filter configuration
  selftests: mptcp: remove rp_filter configuration

 tools/testing/selftests/net/bareudp.sh        | 49 ++---------
 tools/testing/selftests/net/fib_rule_tests.sh |  3 -
 tools/testing/selftests/net/fib_tests.sh      |  3 -
 tools/testing/selftests/net/icmp_redirect.sh  |  2 -
 tools/testing/selftests/net/lib.sh            |  2 +
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  2 -
 .../selftests/net/netfilter/br_netfilter.sh   |  3 -
 .../selftests/net/netfilter/bridge_brouter.sh |  2 -
 .../selftests/net/netfilter/conntrack_vrf.sh  |  3 -
 tools/testing/selftests/net/netfilter/ipvs.sh |  6 --
 .../selftests/net/netfilter/nft_fib.sh        |  2 -
 .../selftests/net/netfilter/nft_nat_zones.sh  |  2 -
 .../testing/selftests/net/netfilter/rpath.sh  | 18 ++--
 .../selftests/net/srv6_end_dt46_l3vpn_test.sh |  5 --
 .../selftests/net/srv6_end_dt4_l3vpn_test.sh  |  5 --
 .../net/srv6_end_next_csid_l3vpn_test.sh      | 77 ++++-------------
 .../net/srv6_end_x_next_csid_l3vpn_test.sh    | 83 +++++--------------
 .../net/srv6_hencap_red_l3vpn_test.sh         | 74 ++++-------------
 .../net/srv6_hl2encap_red_l2vpn_test.sh       | 77 ++++-------------
 19 files changed, 87 insertions(+), 331 deletions(-)

-- 
2.46.0


