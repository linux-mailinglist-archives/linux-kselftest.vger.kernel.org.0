Return-Path: <linux-kselftest+bounces-23502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 068AA9F66B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 14:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64D8189369D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 13:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D971E1F2C31;
	Wed, 18 Dec 2024 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mt0GTFMX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF851F236A;
	Wed, 18 Dec 2024 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527400; cv=none; b=Ph/b+m1/gk4U6iLhkn+sfACoK+fx61HnDCehQEnYRSma4xBnhXkYOROW5ZsCLn2H/FFTXRdU9KRlujfJglJNLVFFgs4J6KWnkn0LwKVGSSs38B5E4GyrJG2JSPRvTsiiK+djjBKYg1O3idZ/g0Wpj6k8rtdD9tgfcWcJ7s685kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527400; c=relaxed/simple;
	bh=cjTzwWbCJa7r3TyEGggN4J7HFrp5Bpypfn8vCgGnGtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N85RVcmj4FjlwCy6ems+pvHwYTBwOaaoUIJXnNau9jGqJsdDmaWnHVpi2hPFg5bDysE8CaHeVQouHnWwH+pqqgD+EwSb0v0flRxOd64YN4RVaOUpD0hDgigur+YRnx2But4DNZ3IGlrtGfOyYWbS+ExoHodlKRrWLcWfeo0qIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mt0GTFMX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728f1e66418so5660108b3a.2;
        Wed, 18 Dec 2024 05:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527398; x=1735132198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWtx/GpPr8Y7UYus5aPINKHxwSB0EzMFBw6o16b+Q3k=;
        b=Mt0GTFMXgKO9eS3uXRG7wKLOkih9FqcuXtN2dHpF0Q4Bok3NVoZAbQUecJhy832hLR
         7nNaLKiNCz75LJKd/3nrj4u5UNSOcYthvBqH8pvwLAAq630Eb0XrUAlfxdrYAv0PXXC+
         NRc9LHrPCoh+DDLUCCfVBqAWQJXG6p1bCwxrvxFvRM1MfJScGJL0iAw3h275d4kKppsY
         ixzn0nWd4uZSVSTHUeRglg9pHBxLDr79yBb5iOppILXZyTPj0TaYhBZqfIVPOdHt+c3g
         d0yomUBohUwl36hZEp7/LUnabEwg+13zHgW8dZTPu8Fo9yiypBehvUzTix2ZTe4w+21q
         MvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527398; x=1735132198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWtx/GpPr8Y7UYus5aPINKHxwSB0EzMFBw6o16b+Q3k=;
        b=wBZmwvW4r9dPEklMZeZpNa4YL8UyVZhKMBubYkoah9IPUy05i3eAaHIHIeXpY0KhyP
         mTbtt1cum0In9i1SkYp7R2w5eMAJlrqqWG9txLupokmn0X8NF0ZlY3hz+oOKgMsNhhK6
         k8Cz3LjEODvsQKCH9k7TMB3ENou/TPVZO/0vKJdkULCzO5qCzAOyK26xV2MfVnkiFQhJ
         tb2a+nyy/IkNXgu/wUdM2PbgHKrT+fJaWJxzX7DMJl5lb2ifcN38BkMniDjSDpUXP5k+
         15zlDL1TvFg1LOwP0B3IvW4eV1RJbx3r553UHanKyUnUlh5BiP73bnoaOqV+bfobIcyk
         88bg==
X-Forwarded-Encrypted: i=1; AJvYcCU/Mix1GlTNATgVxMbZ7bOqQ80sf3RE/SZRauH8zoQSuG83Hl+Evl/yG53AysbekG8pf4mGfSAbpeHm@vger.kernel.org, AJvYcCUG+U6h20BdyA39BPVoMbjBYTGNDc1N6Cc70lTlAyQkojU8744cU7Q5dhb4cyUDrEXxnrH9qzACzSbW@vger.kernel.org, AJvYcCURqLRiJFSQ1tdLdn+7XPtv4JT0WwviMRm49o1ekmydXkuNCBRY+sDvB8HA+eXazuOCaRw=@vger.kernel.org, AJvYcCUX+y6PxKwmhsNiepiaGX/+/xhiDOW4o5iC13SO5vtkH3LbU5zbikE+qsX+W6K3oguVssn+lbulgrv7K2x3x8Y=@vger.kernel.org, AJvYcCVNmxwiDB+Bf6iqqXnpUg2EApZkn4oikDWSiIuig4jqdxsoLB9FS5acf+wky50rjUE+VtJ9EPs11ZMCt57E@vger.kernel.org, AJvYcCVTXAl/5CdDCg2PLgkjroCnaDOUILPMnSfpljuJ3jCTOsCw2HGc45qlf33gqtyuo1KFsVv0XT95pYrKyHiWTrgR@vger.kernel.org, AJvYcCW900/P7MqZujJpET65zZ8XqTzO2z8AvN1eQwVP2x6A+xpKKgkNOUKIBfRp+mmUF77HJgCKBpdKTk1EoQ==@vger.kernel.org, AJvYcCXXzm2Qfyv5kd+vqR653ytDxBRGyiw2CAIWr7Ogmvszk8TeBpfXi5pMcsObs2PfNRj8fKvZHCh8z6vcVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6KCKAczYpjD7Jz88Z6Ar1H5MqjPnm/nhmZ1ENMPqjdW7eudhm
	hHbSx8H1JD68cnur9GDqWb4ZXXahOh8UDpQi6k6CKb7cEUYbqvsgJbKoEKKnOv4=
X-Gm-Gg: ASbGncvRFwhCp/2vglDdYgkD8Dxgq0Y+xt8m6+ZOMmGYxT0Vwk6NSaQlZLb3yYPYE0e
	Urb1DgVTYo/jVrVMog930MXU2kg1AVajhcr9jpKbGNUA1o9/QD9gE3g9oGPjah+0/HR0HFobiG9
	DiBuBfEY9uZaef+9/noCt1+FY8i4UN/fSFgcEtL9OG1bCCdp1TriI6ZqAMxnVAQ5i9cRtRO03WL
	+heMb+tyzGpVVfqMc/qsj9msRefFNIP2C+5O5bzybYVxXc=
X-Google-Smtp-Source: AGHT+IGmYU6ujKxLBy1JGYsxY/MwVi8oxkRDUmwYNBJP1y7XmPRqmJNLVIgjjMfYAOzzfAymm/3esA==
X-Received: by 2002:a05:6a00:35c3:b0:71e:1722:d019 with SMTP id d2e1a72fcca58-72a8d2f0b92mr4132701b3a.22.1734527397729;
        Wed, 18 Dec 2024 05:09:57 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:09:57 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net-next v6 04/11] ieee802154: 6lowpan: Use link netns in newlink() of rtnl_link_ops
Date: Wed, 18 Dec 2024 21:09:02 +0800
Message-ID: <20241218130909.2173-5-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218130909.2173-1-shaw.leon@gmail.com>
References: <20241218130909.2173-1-shaw.leon@gmail.com>
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


