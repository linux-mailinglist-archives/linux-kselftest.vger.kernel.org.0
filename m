Return-Path: <linux-kselftest+bounces-29144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B64A63227
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 21:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE7418920E2
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 20:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4C819DF49;
	Sat, 15 Mar 2025 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ6w/bqB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C685D11185;
	Sat, 15 Mar 2025 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742068858; cv=none; b=JzAN+CV4QADcUKxb4p/EwACuNwUyzmeHqvEh6JEin5EApvOUIJiRH+x5uIhKOUYzdtfzDihEL0e+sTmAivZEJYkXKiSQ0HvFihzkWwIdd3Tfw+4zEuHO/GZV1NQe8VUOtNs7L3De3Yi3N8C2yaTad76xqBvFwCtIsHOwmfIF7lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742068858; c=relaxed/simple;
	bh=G/yRi1RkWD5UbSObIL3zoX8Hp7Dk5qAFsA6XXdFr9Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BBTeqiDPCylxpDHngn4MTmvJsoqHlrduZl6mVONE+s3VfX66ak/5EpYccMeH6vTaQb+eBt9BI+nd1vjvsNgsJ9jaWZNc6zEJ5KIVMi7kBLZ4JlpzYmI4ExAqfUa6q6AFjFWtZcDq+mf7rN/HUqMvOXw66tjI5RX+GltxijmHVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJ6w/bqB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abf3d64849dso521336366b.3;
        Sat, 15 Mar 2025 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742068855; x=1742673655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QaoeBv3gJPJ5tKrPKZcOsUFoglZ8+F/KcBx8mhaIssk=;
        b=WJ6w/bqBZrRIlBarW52BWT6p/5KXRlS+8igHh/k1uGoeq/4fLjEIi6shzpqW4XK6+A
         mRCQ+zdZQI4QfAnKK3KS0DTKFVtPSAwGcsZKOMPHTcAP85eYNsMwCYzwa5C83W+CaonU
         IkA771bpbZSc8M9QnCgA/PVTpbS5OXNJCtJ+RYGMxmwbfJK4niwDMaUYCNchrAi+e04t
         h8k4OzLxXTluwbnW/PrQWvtV2PM/fZ3NuIz6w7sF8+i80ZeT/mfnZMAvInYn0oXPp9PR
         iciltfHDQUOpCI3STe5gqO7LqZaqpGhzD1BEBGH0jG1L8i2w82EWRxE75TbYC3JUs1VB
         8+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742068855; x=1742673655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QaoeBv3gJPJ5tKrPKZcOsUFoglZ8+F/KcBx8mhaIssk=;
        b=mvyoS/cqyFaZw9fR4MFBu4y2Gupql3+CFwHT+CeG277fIntEoggx4siD/8m2/9zn3u
         ai/5Ca8wOYE4U6fZO693jTEkwDn6qoAAYZ7xPmPDQ/47he8TKO/9tWHW36NZbMTnDLJf
         IIbX+Du4bNhLga8S0NA73jyjDEY+R7wzbYpEFuvGqpZ4DuXj6WP8Y2AU1KV63qrkJjJv
         5lfbbLclNS5SVr1I27JVfRnWqXVdEig49vbFVZ8f+y27q/CNT7dQZ3m+tsFFwqq9lHPL
         g8gSJBEAe+zqUd+HzQgBeJqACZude0hdmf0JkefsZoxJnYCvVZCnVu84XVW3nx2M6ZIn
         CpIg==
X-Forwarded-Encrypted: i=1; AJvYcCUK+xoFCnpwomOSADi/FM1tgG9yFyL39ZZkPgFVltARWxhmAm3i8Xa5oYdP2nm+sRueTf9SdqIfldhQuBAOhW0=@vger.kernel.org, AJvYcCX02HHKREfJvmJb00pwAwDeDTyixpVoiQbZggjuRCJi7gsjudRXbRiY/epDEGGb9T35hv90itnr@vger.kernel.org
X-Gm-Message-State: AOJu0YyV3GcR2nI2jGaZN0uJBt+cWh+LZXdbbyNPx9wv/43CFzb9tFE9
	1LgvjMcPWuc0TDRzGuPJiUFgd6/qqalEhyXshsQecrsE3WLxAVuS
X-Gm-Gg: ASbGncu8yxUqqSa6yTVXYFUg77oB5v6BeE++88Gql6JTAQFz/hcCNmANhIxKCuc2+2r
	nLurhW1WUNxpToI1yF956bKj61Tudw2GLlAcvdCN3M3jkCeDJD2ky38v9ttc/yVfNOYwb9BOkUf
	LwFvib5DB7QdRYZk8jvyY3G8cyAppn1Tur1LJNKX8AjvggjM+PYQHjoxS4TwkZWO+3Y6YPMnQSM
	atZdUaRnLjdUbYmk21pybmR2RawTPxyrVAMIxDqTthSWCAzzP5/Ak2M1/gtWmMRDenAluFO7vGC
	ALnIslPLhoNScU2oTZpCC0FAr6+6YQ/jPszGOhnO2g0a/fLLk4+5eRLhZHDwP2VHHODRB4fAUe0
	EJR4mK4lGdXk6PDBi5y5dxC9Dxp9drPE9Xt6DH83eDtLKeZr3q402mk3fJAKHR9g=
X-Google-Smtp-Source: AGHT+IHSU/jC6C/A2Lsm5jvq7xx0lXG5oat5da9YJ9l08h0SXcXFfdHAQaMZTXQ+xKscKf6OKW+jMg==
X-Received: by 2002:a17:907:9725:b0:ac1:e332:b1e7 with SMTP id a640c23a62f3a-ac3301e23aamr733726266b.4.1742068854769;
        Sat, 15 Mar 2025 13:00:54 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9bc6sm405908066b.49.2025.03.15.13.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 13:00:53 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v10 nf-next 0/3] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Sat, 15 Mar 2025 21:00:30 +0100
Message-ID: <20250315200033.17820-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conntrack bridge only tracks untagged and 802.1q.

To make the bridge-fastpath experience more similar to the
forward-fastpath experience, add double vlan, pppoe and pppoe-in-q
tagged packets to bridge conntrack and to bridge filter chain.

Split from patch-set: bridge-fastpath and related improvements v9

Eric Woudstra (3):
  netfilter: bridge: Add conntrack double vlan and pppoe
  netfilter: nft_chain_filter: Add bridge double vlan and pppoe
  selftests: netfilter: Add conntrack_bridge.sh

 net/bridge/netfilter/nf_conntrack_bridge.c    |  83 +++++++--
 net/netfilter/nft_chain_filter.c              |  20 +-
 .../testing/selftests/net/netfilter/Makefile  |   1 +
 .../net/netfilter/conntrack_bridge.sh         | 176 ++++++++++++++++++
 4 files changed, 267 insertions(+), 13 deletions(-)
 create mode 100755 tools/testing/selftests/net/netfilter/conntrack_bridge.sh

-- 
2.47.1


