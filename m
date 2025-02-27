Return-Path: <linux-kselftest+bounces-27720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FC6A477F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 09:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6331637D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 08:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257272253E0;
	Thu, 27 Feb 2025 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxOM//RP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B353413A3F2;
	Thu, 27 Feb 2025 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645465; cv=none; b=q1gUWxZ9vbBK4JZcIPNRdDchdEvyj33RvS/yJy7XGpQNT8YQvmE3x+FC6JB5BcP67+TFwe6gb1BVob8TS4RhzneuHJpm9mPDtB5RUaVUTbGw8faEVqbtqJ1pZzbhCgazulQbLKX+hpnVY+sjNrjXSva9fqM8WLNfkTVuv+EoBL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645465; c=relaxed/simple;
	bh=osJRx72iR5wDmM0zItYjvKkdxyvdSPyeZ9V7H6SiRLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qnZyuP+JiIanqmNFMfaQSm/7QSHQeCrovndO4LAR6kmC6t6/cJwTf8B0dgiXoUlsxu1R7gIjau9qKQ7v/aeXpMj42k1J6/fJep/0TGMClLRMWydUQho4BfCKjL95D8uqB4gRgv71v7S/Fg6JALPSXubG83vuK3t9Khijy7zn9yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxOM//RP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220d132f16dso8222555ad.0;
        Thu, 27 Feb 2025 00:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740645462; x=1741250262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lDDTkPtct+cToafdbSSTMQ1vEqIbe4HGt6h0hMNxLJg=;
        b=dxOM//RPQYXqHoOzUEJf4Uzrbekhh1RSl/N8zh7IY6y5ZWc6IxDQ1VWqRqgdpHampZ
         LvM3mLyklEY/36dHK6M50kr2T5bYT4nWs7TXJ4ljUmRS7/MqA+GoKyw5G3gUoWdcOp8m
         2B7aaJf/Iv5Li6f8afU/aYn0K8wBTpgwL/IYpEtuuXHMjB+7k8+AL2LrtEnzJVsbhhGm
         HjlOYT/U66aAv7U5fahGd3tUWe/duenNILEfVwQUskRytrYEBUVE4CD7ppFAZTlczPTF
         mvoV1h5URrz1NO+EG2XmlA9toR/o7MFRWfqI3zk8vhf2P4sGEY38XXMNrmyatIZry1n8
         3PDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740645462; x=1741250262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDDTkPtct+cToafdbSSTMQ1vEqIbe4HGt6h0hMNxLJg=;
        b=BpJyFCsfJ48FMbzH9hW/CIbh9NnqSBy6qqq96CPQJK8sQEekQer6bq1XAhrXzX/Inh
         DcWtRdionTE5fmeoEdpO16n0D4cnapWMS8DvTbJ4PV2eMw6mD6PwJlwzZ4nc84g86nZn
         ly5CXuv6KEuzwR6l6XESe8YH97kb39hQyxtGwI2DN5EH1TaHd7Tn3vq7gmOS4HKMrc0W
         JpLJS27dgIdX5pTUaMCbMfdb0KW/K2JaZTDzSRhPx0hfFkL+iLD+av9Twjg7xS2XFjY+
         sbYrj6posuwOlgKHE3e2GH623FffnHFu1Co/j26H4pMrSEOAbP8X4kUZY30yYSj9X5hB
         Q+iw==
X-Forwarded-Encrypted: i=1; AJvYcCUWdJUc9CTyzXDLovyAL489Doz3LUHdecbTv7hzlW+YIWrIe4ci5J94ecqVwK9MiV8MMnyydgfPViNuBjpMCYQv@vger.kernel.org, AJvYcCVWdnr+5pvkSOC8BX+miFphGF/C3BvolJdlBlxXYNNV6hDyiNfWRKwt+La5a6nBb8jbVGcPOzwhF6spucY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOakbsJ75TfjEW/WupZVZYDpH0sVyXBoPSGLhtE7y8bQ4BY7iv
	wBaxKlRb5dqzkt6Hmt/ZKqOHXkaXRPvkNSsUi0x9NmMbcsNCVLqcLmFfiDN3HtwoJg==
X-Gm-Gg: ASbGncuYNkLWNnm4K2Ecf+bX/9hpX9Je2YqFJRqg2z1GcOuVnHTtUsdZ/29WDPNBrxo
	rfCRnwx1FYp1/v8khifrypye5WIjcRKOBG+V1qGL6SR2oE5k6unJGZujQZaLqkknbAIJIM2n849
	EpTv3lxO4nblsOhRXJJ6z2DnmLeHiyy6RuLDZtwjUwGoCiilfkxb5bdXsSygdgNdbW3VorOa/S8
	YS8Fc6ePNBivggtLCsWInBEkVgmrVnJ74qIV3WHr3iG6AA0KpU9tLcCHDaYiEUirQz6b8s6RgkY
	4maiLq31KA4a/hh21IwvtWnnwzZ5v7xoRHvOKWi/xbRrjw==
X-Google-Smtp-Source: AGHT+IFTsOv4OZTdg0RRL8hOfOmWfjj1/2uRp6EEpZPXijygZJr2zqjYbBRiyKWEznjSRp7BSM106g==
X-Received: by 2002:a05:6a21:178a:b0:1ee:650b:ac22 with SMTP id adf61e73a8af0-1f10ae7384cmr12534971637.40.1740645462359;
        Thu, 27 Feb 2025 00:37:42 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003ec7esm966796b3a.153.2025.02.27.00.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:37:41 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Jarod Wilson <jarod@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 0/3] bond: fix xfrm offload issues
Date: Thu, 27 Feb 2025 08:37:14 +0000
Message-ID: <20250227083717.4307-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch fixes the incorrect locks using in bond driver.
The second patch fixes the xfrm offload feature during setup active-backup
mode. The third patch add a ipsec offload testing.

v3: move the ipsec deletion to bond_ipsec_free_sa (Cosmin Ratiu)
v2: do not turn carrier on if bond change link failed (Nikolay Aleksandrov)
    move the mutex lock to a work queue (Cosmin Ratiu)

Hangbin Liu (3):
  bonding: move IPsec deletion to bond_ipsec_free_sa
  bonding: fix xfrm offload feature setup on active-backup mode
  selftests: bonding: add ipsec offload test

 drivers/net/bonding/bond_main.c               |  36 ++--
 drivers/net/bonding/bond_netlink.c            |  16 +-
 include/net/bonding.h                         |   1 +
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond_ipsec_offload.sh | 155 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |   4 +
 6 files changed, 195 insertions(+), 20 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh

-- 
2.46.0


