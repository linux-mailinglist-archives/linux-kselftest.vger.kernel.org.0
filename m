Return-Path: <linux-kselftest+bounces-23905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1E4A01495
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 13:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 661687A156A
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 12:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3817E1C3F13;
	Sat,  4 Jan 2025 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMebCQ1Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9761BDA8D;
	Sat,  4 Jan 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995502; cv=none; b=GvkVE6xRHGJQhv9BL4d4Y3aX+O3gP8vONeqpPiwuJQO4QYh90DAaS6e0KuCzd/Y5gBzk5KYCQTR9mZuFnumQ8gkSudeqa9jFbHklsidmnjElDsVjMPju+0ZCh+etuxt1RliLwnHQfS9gEjHr2YSSgDreUANm5qQ2QjidITyKodQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995502; c=relaxed/simple;
	bh=cjTzwWbCJa7r3TyEGggN4J7HFrp5Bpypfn8vCgGnGtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0s3LXSQylu7DVt/nicqD8rTq+5v+ocHtnmt3fAHQ/pTwLo/MFz+CAlOxQA+IGKTLtawbpbW+iouYnW2Os2J8aQSYXnUh/0FxyKkS505wkKuBO02X0AqKNxwrA5nZpBFq14s79Eujeqh7ypBb9eDGsr5qXcVdFdnyh1E14fP45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMebCQ1Y; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216728b1836so164388365ad.0;
        Sat, 04 Jan 2025 04:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995499; x=1736600299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWtx/GpPr8Y7UYus5aPINKHxwSB0EzMFBw6o16b+Q3k=;
        b=RMebCQ1YtwPW0hes65CCnum2Tk2NjGcuhrwe9x8SEIrdOhFtHDUOjcUECPuw01I/py
         KBw5BIPFfvD4VqVJwywzmBmmNYH2uTfXBNGG/THlQQlVOXgBe7O9RhUpgC9N73an26+B
         kJyDvhz10oaFSYqI1IdU+QmeUL0RMN9ain/UmPEPgi5vovnwLtfavURe/iT1Y5n+hotK
         WB/CbI6kEVlXMKVaLxGE2t+ZebgwnIsQeDVfnO41Pq/eB0RamJxmL3MWYamidg6yPj/f
         ai8IyhSOZ0DTqfN3pOF5HoQviRTHk/7k1ejd0hEt3Bx73Ofc7ueuuLoQY/phlVW0cYx/
         yWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995499; x=1736600299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWtx/GpPr8Y7UYus5aPINKHxwSB0EzMFBw6o16b+Q3k=;
        b=LfS3eCwKeCVPxMSY1E+SALnSf/x9PfaqrZBk9Vysz6jbbd+ePdE++D24E2qUx58v7y
         81JVZOaaT8gLG91PsIjPHuifwAiM737RsS0I/6nbXktAYUTLyximXEPEO2dsc2YsH3JX
         A2ymYUjaIWSDRXYnR0/GcjZgQwihUCa+ntbOqK50jFJzvp52jQj0Cc22Glif/NuoF73d
         q/7d7cOKFMFtFC1hDXTm/QjKT/blpnp8r1TWqwO8DG4n3Ln+FI8B3Z3D5kSCfMxvOzqB
         xrYsSdk3q/TqUFsstmKZ59sZaeXm81+kkpooGOsZPbPrS+oVWyl/5FQiYG+RZ1KBV2kR
         YcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeRteHqy+9WG1WX/0/1sZbie7dA3mKl7di0Ucp2m1O76XhzblzSbXzJEmzOhdHOyCzfM+ihYHPPd7nWWAmnno=@vger.kernel.org, AJvYcCV2xHradJjOcpceSI4oSCWb8xQwEsYP6EafvTOpZDf7SPCgv86E5SMrLGeaHiQL6OzXqIWXYEgbqkMk@vger.kernel.org, AJvYcCVPdXjFAMwVyGUoI9VIicG1SDsVkoRafXDgucg5505kR2vMEUw9ODL3BCUOG0YF1yMXCJd+kSvY3Rqrng==@vger.kernel.org, AJvYcCVZi3/Rx8nb3hDEsqWtG8scM3r3jrZi1nHdIvwYb2oM6F6RNXcXu3Eu/qHkfXAGwgDTegI=@vger.kernel.org, AJvYcCVzUCAj5RtS35FYxOeMxROnnM60K7Qa7piYUAQTvdtdq1Lj/bb8fhu2c68jYOIAdVYqxQPJ9MJ9qKLr917a@vger.kernel.org, AJvYcCWIjo9POFnagCdOidKBQt4S09eWRa/5loNsOlWrrCEDg9sIpLxbcw9rCNMt6zpW3cJc5Nyx5u1wpU6Q1MpWsM8N@vger.kernel.org, AJvYcCX0iPseT3ecQ2WmPm/6O/xXIHzoYaNZSlyBLUkmWMjNG1dWbPS8Ud3/DBhR6h0iWPt7gV7HWtkfGlsoeA==@vger.kernel.org, AJvYcCXcpzm3MS5EULJkMs6Q9gKjk9axjhXBzEck/ZgIepKQOT4Kewaq2dAMogB4I3FU+nKHyMthowFJvHYS@vger.kernel.org
X-Gm-Message-State: AOJu0YwerixqDASZX4r+xXIEXvWW5VUMfVcHxCWhk2i+e1ewrq60SJPr
	RVCdd5G2a3B0VjSORI9WIXzJxRChdsxLkIR+mOtVy3HL5RiltgJk1kzfcUXgTxo=
X-Gm-Gg: ASbGncuDZ9LoRBnbvOZqjG59obIO7DPPjTObFsWLPGNobvGKCGMkqBtdZDQma72v0/G
	/EZSDDHHVDaN6L87d63GOZh+qJBQ/CvoEtHVdLjL8CNeoIaZt2+f6h0jNPmEt9vxX83hWHZozPy
	ZK5LSLpxTb40bZZ1kmhz08z6YNDJz8UNoMHSAvNwHzLSjbt0sbDtGRXrM5x9GWPqZb6uQeNpmmG
	TggEZI/CcLNLWoM8vzgihq71FY8gXsmICbol87BxnWWzig=
X-Google-Smtp-Source: AGHT+IHIkI4kgOvJJQ9O4vOvA6fRMUVnhOi23ydvn4IOYZv1bvM67hPwcmTlhhKLeOZA8Exp/2drag==
X-Received: by 2002:a05:6a20:4394:b0:1e1:b430:19c6 with SMTP id adf61e73a8af0-1e5e04600e3mr77828034637.10.1735995498951;
        Sat, 04 Jan 2025 04:58:18 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:18 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 04/11] ieee802154: 6lowpan: Use link netns in newlink() of rtnl_link_ops
Date: Sat,  4 Jan 2025 20:57:25 +0800
Message-ID: <20250104125732.17335-5-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104125732.17335-1-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When link_net is set, use it as link netns instead of dev_net(). This
prepares for rtnetlink core to create device in target netns directly,
in which case the two namespaces may be different.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ieee802154/6lowpan/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index c16c14807d87..65a5c61cf38c 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -143,7 +143,8 @@ static int lowpan_newlink(struct rtnl_newlink_params *params)
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 	/* find and hold wpan device */
-	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
+	wdev = dev_get_by_index(params->link_net ? : dev_net(ldev),
+				nla_get_u32(tb[IFLA_LINK]));
 	if (!wdev)
 		return -ENODEV;
 	if (wdev->type != ARPHRD_IEEE802154) {
-- 
2.47.1


