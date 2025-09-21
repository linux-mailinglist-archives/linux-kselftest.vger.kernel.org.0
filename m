Return-Path: <linux-kselftest+bounces-42036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5513FB8E7AE
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 23:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDEB73A95EA
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 21:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7464B2C3251;
	Sun, 21 Sep 2025 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjDEAJD9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAB623956E
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Sep 2025 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491781; cv=none; b=uexJr1wyK8VMhushWlS29Sg17hCTIygXnTmTHS2G7pOBoauYVyNGblMnQVmdPyl/18mk4cj33L11Vq85uIkBytzoq2wcM0pI2VrI1N5juWWlnVdA8cDt3SZVgl9Eh8KKpbSy81FyO4xOlXB4rJIKg1JAjgoEDSGG4FwDVuGb2+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491781; c=relaxed/simple;
	bh=b3zVpKcWVRzzAV4PoKPYfkAzAKs5wqpx9sDSqMK2hLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sZ83CJChq6jWFAYmzgcjMFg0g/AUFuSLCZNe0F6WrSN1OGftwGcN69POlxiF8EiJDo2QqW7Ie0n7F+CLwA7PHrgiHPl0FhTXhTGBPLqe3mul3B91w020NulNMTksozITTC0e0wmnn4BYF+Cc89Y5uDgOBaZS+DZ7JdyTmgKbcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjDEAJD9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so36145175e9.3
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Sep 2025 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758491778; x=1759096578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhtGHWyefO4/6V0Mfz8aoHHvCaYrHjSgfLtudKA9GGM=;
        b=FjDEAJD9JBcnpD2YqE1HNJf68Kp16Nf7OIqKfiH3lZ5j9TASjXWCXnz+1MMqiPW3hQ
         eDQkGosQ7OSPKDuRlHw+2og2ngb0MtszLvTcwhoyHQJlP9qY527FX5g1K0OyHEJuWmum
         ip4jY/el2lNXz0ZN8uAQsB02RYybEwj3XDpPLqzvtS3YiJe2oLYyIR8UDgkb03jf9Rhl
         gjVtalOGuVb8BKVawrtn9fzbbUfvofrEsNKr6knKU29D72KavfYy6faQ09domfoSgynL
         2FTN6kvzcghCfX/XcEHRyK7XbtUnTBWdnpIEJMtBoCqGe5yJK/DW6xsXvjr30mfDSSSj
         Rkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758491778; x=1759096578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhtGHWyefO4/6V0Mfz8aoHHvCaYrHjSgfLtudKA9GGM=;
        b=tYEudIS7Awgprn0rthI50gfmdb1bHGwMvfkEBAsLQkxiQV2H0Onr1uSGahEhvvd90c
         IIcrXj+Rpz/aoOjFia0ZmSKb3/7pH1/Fu173wUrSyH6+3prrjcQtWg2SAF4362Jgb0JH
         BpYzSfIyku3oG1KP9/lOCpMCK71gxFtV6DXttMFY4S6oBJmnNrbENYWXziEBDYr/loEF
         EGDfnemF9mYDm2ETqV7kxX2lp1QEsO8OX7jU3XpCnH1Ynwcvy1jC6tC89AwBUvU+MYMg
         c9dh0fq1LifnuwTZ1bb0j9D7+uFmeDMest2IqjgWz6xXfldhtJJuaMQ+ZvOu3RQz8l96
         CCCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCHF0jI3i19vddn16lh9eZNTOPj/uATz0wCD4FnVboRH3JMSjYm83umyjCPpjcfA4FgOxZUKya3XQIuKDwB/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/3wHObsf7epJ2ojTaQoFquKgY1ZjO9DU9zboLY1hQcda5NHEi
	1uHpAgRMNrdw28/LrpMhSCz3P51uXMCT6D15rI2sdAJy814nvgdZ4K2/
X-Gm-Gg: ASbGncvz8flF3cbAITqsTjUdi5UNRDSZNNf/H5fvFuyxedNoNrJQzfDi2PZvL3mMcDB
	YAsfwS47lUIws52/AA9aXW6m/3+m+H/2eXQY6z8ucbrDUjeBXIP70LvlumE6xa1YJPEWP7iJjeL
	6Tg4TpZBBX5EwBBRCnjg+oGAjmDdQWm1iAEgLb2tvQnxs4ctXmJ+hc6pCo3VheTMtV3M48rQpZq
	qHAhgE1ZmPE6EquVJ53ElASctO9vdW7glHJ+jLgpSzoJeifSbbjmBQLrwt3B0pfHHM+laS5lT7j
	uaU+eWMs70syC9OKRN2LIwhenmPz7AYzAGStYjLO0XcmXRxSNY6GmTBQuUNgGtfvSCpy31Qczt+
	xSD7/GWqFI+I8Ei5HFPXQfY/1UBM=
X-Google-Smtp-Source: AGHT+IFT0qyTjpLKdlSbhcPvNOEnjMAPo5BNLKxqpXg6Yr7gdl5NTyeTy6K7cKPbDH0s64sbEvWqVQ==
X-Received: by 2002:a05:600c:1d0a:b0:45d:d97c:235e with SMTP id 5b1f17b1804b1-467e75eb7c1mr99681985e9.12.1758491777778;
        Sun, 21 Sep 2025 14:56:17 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm5873427f8f.57.2025.09.21.14.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:56:17 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 21 Sep 2025 22:55:41 +0100
Subject: [PATCH net-next v2 1/6] netconsole: add target_state enum
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-netcons-retrigger-v2-1-a0e84006237f@gmail.com>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
In-Reply-To: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758491774; l=804;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=8V6SGnkKJouMeVLTzdn4Y5ZWQGfJsCbNdTJXQi+AdQs=;
 b=GPUX/q1b7aI+x80Z5XhKXmAjDjPDbZN7GFNxh7sBmqOv0fRzHd9Xe9St57SEnKbucx6+t9YIp
 B9ffcgAWoWIDsCDTfQZq2MO4jk46AtFFsedK+33gImVrfK6MiwcQukg
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

Introduces a enum to track netconsole target state which is going to
replace the enabled boolean.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 194570443493b1417570d3fe3250281cffe01316..b5e6a9fdc3155196d1fd7e81def584360ecbc3d2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -117,6 +117,11 @@ enum sysdata_feature {
 	SYSDATA_MSGID = BIT(3),
 };
 
+enum target_state {
+	STATE_DISABLED,
+	STATE_ENABLED,
+};
+
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.

-- 
2.51.0


