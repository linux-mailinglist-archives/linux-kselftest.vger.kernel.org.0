Return-Path: <linux-kselftest+bounces-23544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6129F71EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 02:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B9D97A2B26
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 01:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252F412B169;
	Thu, 19 Dec 2024 01:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XoB2HHJy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49BE83A14
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 01:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572529; cv=none; b=nL6YdV/Uc+staXDPHP2Af9pM2qx+HTUcQdF1EFmmLF+yDuWHV3BTXngywH2Zen+Kk2qVJwuJaxrfeSRXJpSyK7b24tHxMIMY9vplsjw3vvmltbaaagdEQYRl4/DKqVtRQOnk/pklLprhYFa9SGRoIlennpCIKvpICjT5/cnxZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572529; c=relaxed/simple;
	bh=RY/Tuspo1DCFRvpCKqQYIvf8w9XDMBN0DkDSzZ4QpY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kNa5gWLYWNFrKOPnFJN/gyH7mXvZ46+qbkz5Snx0R79TDXfjB86MfAguHv10UTnvSKpYDw3aveqaqhvF/61AlGkkWsuBSHp35tKpdEHvTGdIaCE1a8v0eWpFoxKQ4vzdGcNzLYzV3vdHgAXonrMJcT25+GsRQ/A4Uhw0vdxzqyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XoB2HHJy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385deda28b3so211526f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 17:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572525; x=1735177325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1Fm2KD7luUDhEb4Vs1/jF2TESvp7j4CV8OblpLPfSM=;
        b=XoB2HHJyri4fR2kwskR7xtc01qPI+lnKQNXkplcUjfskZUvmY7NZ9HQW8zvEeo6s0k
         +FaHwql+Nl8SeUcge9JYNXKffIheYbJ21JIgmu+/4ZbaOFOeL/AZQHgrZ3cHd2Gc7xmU
         5Yy+SWQEPvJrjl85a/yx855vyAdGeU289zkR458VFyNSo1hJfbG42k7Xh1AtyzgTwRd+
         kGPjA4pvx2O1KL7z8C1euxdPX8CytfXZ7KgQqhMRmeXcqG3EKHg8v9tu+wXqZag4yZJa
         mLAeN41I1I11j/V99/NLEhElNPqNgd3iN91JA7skVngPD7MZhTaxE6uMUallyIVPIQol
         UIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572525; x=1735177325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1Fm2KD7luUDhEb4Vs1/jF2TESvp7j4CV8OblpLPfSM=;
        b=qJrYra8xIQIHL+TfOv+VxoSST1v6uENOD6/uV2TJUly+73WCFPUbhaAcRr9CKogc81
         e+qdTsKeUldEZLgZgbDfuxOCKKck/C0fgTIrdL4e/xoA9+K5jfRZAIK1mXt90lePz75X
         9ydTcM8j1wAN2SWyCZQLlNBlmF28c8Drq8RW2qfsxZlXo4C51DAVkrJ2lzKDzYxOIF5K
         S068eDscgdW5YaRlQUSISjOb9/N7n8fyWJHKqS4ZF4XS5a6doeeQN6mdSUZin8G4nktY
         BBJZxWKXxL7aDVduPdA2++q1JAd8Gz8DNMwUgLjkG1VD95IFESE9N5VPape5U7edcDTW
         /xZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBRhZWeUecnst7JYN+FFsBKahTbxN3E3yuPVf0Abs8DMywx1+p4oAqplEz8W3QDGP4Gjn88KzkEaHVLEJA5M8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1wBqxf2zSKDlVakyCd74jh8cIahCPeJ64J3vwdGfieSfsHNX3
	AUMrXs0XaNMWLnzj8ST4bkGJEgN2iN3wIPP++IxnUs7vqh/8xuXoc54GTDqvXdI=
X-Gm-Gg: ASbGncsyTMcu+3ojeV7pUjIjE08LsnrS5IL9JL+iRn5ZqGmGjZe1nTElxNIc7JlBKLn
	vNvnIlMtdRjyoiR5qfhaWFdjRSqm2cnrIlBME+JRKsdvfsYRTRxNXGeW9w2zhaTUr5BlJjztw9D
	I415LxtitXjL7HrsNVlT4nBVzcCeSnv/DDXSyWQ/dRQ3Cwtg7P0Jpv7+iqrj0wbGmEamyyaQb7q
	lIiBbdqxevYWQorn8hWya60omrbfZEfj42B8bo5TraH51OZvPhK6vEWF0Cvo3LbA2Ie
X-Google-Smtp-Source: AGHT+IHoO+rFcwcQmYjUEbRKBFGbPRrDf1EsqbMsHCTF2Uab4cVKHcddINm2pY26BLLGgenOU9t1NA==
X-Received: by 2002:a5d:64eb:0:b0:385:deca:f7cf with SMTP id ffacd0b85a97d-388e4d2f50amr4897451f8f.8.1734572525185;
        Wed, 18 Dec 2024 17:42:05 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:04 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:41:58 +0100
Subject: [PATCH net-next v16 04/26] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-4-3e3001153683@openvpn.net>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
In-Reply-To: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=RY/Tuspo1DCFRvpCKqQYIvf8w9XDMBN0DkDSzZ4QpY8=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oU4n6fLWUI45C9vC+BafZyKqIvpe6X/9OV8
 A5AxTVY2faJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6FAAKCRALcOU6oDjV
 h/YcB/9om0FTOUTpVaEvCyRaJaTJrzfntFwGe2nLA2kd9FG09sb7tJNzhhmDHidGqkSLy9KBiXP
 gTtb+doXJ4DcPdj9z9He54zdhJ7i7oHEmxpp1z8sPvjdeAY1HWxpHqHJORClRhf0d+lNXtAeKRt
 6Db8Vpa9FeKnFVs0b5bPeZH+nqe0QKb1rkITJK/+WGCnqRg9WI8QkY4jUK52J936nQzMaOskGM+
 2O61zRjt5+dmVD00C7E3QT6OLz02QvBRs23Q+j/2vOSFoukS/vwyzgdvVoAKwautHrRgdcRazWq
 52nInmYM+EX6UTR4mQ5HnnYFUm8TMUZwS5jMQAQBJL/7rIU0
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface configured in MP mode will keep carrier always
on and let the user decide when to bring it administratively up and
down.

This way a MP node (i.e. a server) will keep its interface always
up and running, even when no peer is connected.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index d3eebab7fa528cb648141021ab513c3ed687e698..97fcf284c06654a6581be592e45f77f0f78f566f 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -23,6 +23,15 @@
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	/* carrier for P2P interfaces is switched on and off when
+	 * the peer is added or deleted.
+	 *
+	 * in case of P2MP interfaces we just keep the carrier always on
+	 */
+	if (ovpn->mode == OVPN_MODE_MP)
+		netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }

-- 
2.45.2


