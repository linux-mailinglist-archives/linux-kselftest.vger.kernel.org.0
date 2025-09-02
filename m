Return-Path: <linux-kselftest+bounces-40506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9041B3F5CA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4A23ABB2A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 06:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7442D7DD1;
	Tue,  2 Sep 2025 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlQd74Q3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78AF11CBA;
	Tue,  2 Sep 2025 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756795521; cv=none; b=oNeYEH49gVqaRMw9g7Itvi5xix7zsSiDk/w1bfwoFgJNL0ngwYZrveITiyYtTYM05sjlqZlwW6gXvfgLNPHP7M16LNasDrNnvCFex7a3GGBftHYX8Q+CqZWex+FqHNTl8BcoY5p/ndfHy3r+A2WkTbmltKws7JlaniXb6N1qRCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756795521; c=relaxed/simple;
	bh=MZDGet5HvbyJe4I49Po29yzsJmGJlefb4UaCgiQD2as=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XwU7wxZ4PubMABEWApE5oy2lrPAwL1La4wngmB7AS8Bmba7MwtXQxdY1jawdpCXJzK+jf35z+YXaAiMe1KlSMYBVE8qpReLfLOt25z36t6IT4nr+WbwALGcY1ZpO/yqAu5H9ImrkqAK+K7+/inPh9etwanl+MVAvC/TlaMEun84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlQd74Q3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7723f0924a3so2979476b3a.2;
        Mon, 01 Sep 2025 23:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756795518; x=1757400318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1KdY6vBL5GsCdWVNZfyRlg3w7cF/fAODtNwJr3SZBw=;
        b=IlQd74Q3OgP0II0hXSGyXv2/YGj8xuhPFLxd2GiQCR2P7BUl8s0UaZZ2jjanIj8j29
         EiD6dykSQscMeKhkeeVJB7nJS5qLrgat2wBC2cawG3YHZTbVfajNOvFpqJsE1Zz+abQW
         GEwlQkhQOUeWYSr+UxKXDBQbeaiwDAvQHUoK76Nwp//Z/Rhpe6j9HuMu7MyJIpWcSgso
         oSo/8tUSubdGAA6uGE5qsnAcS5ffgoBJ5xHwXiPrY+k9YfCWvlv10ydOMbQgMqcbafG8
         oKk041Vxkt01VawFwjB6a3uhiIUfRREs1bH+IIk0kJSTeD8IuLqRBRniGowg749Hnf3u
         CU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756795518; x=1757400318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1KdY6vBL5GsCdWVNZfyRlg3w7cF/fAODtNwJr3SZBw=;
        b=P8oBrTMsGDXkQnZt+BN2KMQ/8cZll1ZugKUV2wvSWm9kgrb2Uy7bMpCRFK+Yn4J7HQ
         ndr6rihGxSNIyKKZR+VdxsOLiq1sLNx1umUVb4TCu4MG6Xhnl/fq+yMwJeee8BF2d2RB
         /PCKZpXjGovbgU3lv0U6vaSWBKSSHdp+ygeY2qYVXCE9U4GkRMutm8OL9QZcg40yiNe5
         /2pf9qXB+HV5uHhgwt2EF+xJfvXzn0O9bXJqk7tBY2UX7zURMSDX9BrvtQGC5MWT5ImH
         k+xANGSGd+JP/G7swM56OgWhsymx0jrndaPSK5QTHJBZFpJxWT1NBJfkSuuCeAekqnab
         VWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf858e1MYZLVwmf51tK/zanClqg7B8jSq0ytFO1UwcytSxgEblhF2AXcs1pBVBbKxq0Cbx/7htYKNQsYB9XKxF@vger.kernel.org, AJvYcCUn/u/LJWa6uzuBbvKGf1mch588cnx2xZbw0KzjWtjG8RaDAxYxtAuCfAR2cv2p6btHPU82oD4hPbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7fEOA2bKgMzD7lJ+o3y5O+voK7Rshw3WlgyZqsb5cuxF0qd5M
	F1w3CDypMpPZ1urTlgyNpvWNSGLNE6ORKgT/1MNaq+04Oet+zHRsQOHtkhOBR3gG7dU=
X-Gm-Gg: ASbGncuR7bpe0qIPU4ttt54gx7eFOHKIifGTvT0zxZ3Bs0lBtbklgouBfOepS4GxF+p
	Pe+hV2huvxytLg01H+2mOxonVizRU1zPl6v07z7celPtZmlNJWWmVIeJZI8Bwpwv19VBvDUGy1s
	/TT2JhChn4DRLk34gNVIy2dRczSkliFCzUZ/kgVRtZ7jzjOEqifGWNu1BWrimFWAyTB4Ta+Wt6f
	MLnNEWCa5RvRXrCiXQUq2zyfkgt/sI5CNeRRHqe/nwsvHGpMOHgySa3T8y0ZWcDXGveDPtZf+es
	+FT390jCEFiZbJJVS0mxxzUCn+reUsdlAEN83fc0deC1zxPRGJJ1SOOEHBW6sI5H2nmnaVUoFSv
	CeMSinMN0/0wqHI5DWBBaXDPF/sx6+q0OWyYnu3yZCEdtXWWT/3sx
X-Google-Smtp-Source: AGHT+IFlr6G4W7XvbKQI8j141P+hasUXu8hu79ecvZiU/MNbbbdttQ/E1hJ9ygf1TLpoDLexBr3O6Q==
X-Received: by 2002:a05:6a21:32a0:b0:243:b125:16c5 with SMTP id adf61e73a8af0-243d6f581f5mr14101148637.49.1756795517864;
        Mon, 01 Sep 2025 23:45:17 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd2ea3a04sm10936681a12.38.2025.09.01.23.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 23:45:17 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv5 net-next 0/3] bonding: support aggregator selection based on port priority
Date: Tue,  2 Sep 2025 06:44:58 +0000
Message-ID: <20250902064501.360822-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces a new per-port bonding option: `ad_actor_port_prio`.

It allows users to configure the actor's port priority, which can then be used
by the bonding driver for aggregator selection based on port priority.

This provides finer control over LACP aggregator choice, especially in setups
with multiple eligible aggregators over 2 switches.

v5:
a) rename 'prio' to 'actor_port_prio' in bond_ad_select_tbl (Jay Vosburgh)
b) update document description

v4:
a) fix actor_port_prio minimal value (Jay Vosburgh)
b) fix ad_agg_selection_test comment order (Paolo Abeni)
c) restruct selftest, reduce duplication (Paolo Abeni)

v3:
a) add comments when init slave port_priority (Jonas Gorski)
b) rename ad_lacp_port_prio to lacp_port_prio (Jay Vosburgh)

v2:
a) set default bond option value for port priority (Nikolay Aleksandrov)
b) fix __agg_ports_priority coding style (Nikolay Aleksandrov)
c) fix shellcheck warns

Hangbin Liu (3):
  bonding: add support for per-port LACP actor priority
  bonding: support aggregator selection based on port priority
  selftests: bonding: add test for LACP actor port priority

 Documentation/networking/bonding.rst          |  25 +++-
 drivers/net/bonding/bond_3ad.c                |  31 +++++
 drivers/net/bonding/bond_netlink.c            |  16 +++
 drivers/net/bonding/bond_options.c            |  45 +++++++-
 include/net/bond_3ad.h                        |   2 +
 include/net/bond_options.h                    |   1 +
 include/uapi/linux/if_link.h                  |   1 +
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond_lacp_prio.sh     | 108 ++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |  24 ----
 tools/testing/selftests/net/lib.sh            |  24 ++++
 11 files changed, 247 insertions(+), 33 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh

-- 
2.50.1


