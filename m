Return-Path: <linux-kselftest+bounces-28115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF178A4D000
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 01:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A654A174A4B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 00:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813D112B17C;
	Tue,  4 Mar 2025 00:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fHmWgz86"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396E37346D
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 00:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048475; cv=none; b=AhyfzMQO16GvAcQrfHLAeJAAH2GBl6EGhwN1/zv2Zd/cVFcgSTzgcNW2pwZ8i61TXEKdEm5gwIl4SOJOsr2Z39FAagc/8E+j/QagBFpq61nbrz74OQENrir15atFt6iF9z/fUTSRwUlVEmp5oof3v4QhILJ7F4EUmBlCgRiBhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048475; c=relaxed/simple;
	bh=/xvou7dFKioksUHeuOvCiwiW+/ZP6NzsNB7blkKp/EA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYQcDLU+JOf4gtry/jMGxPX89cWgxgMWCyRgriXhuysJhGRLkH2pR1m49hhvPfSrHVg6Yu1CFTMqcte+dpHs/b6lGv3Ohys+KpiEVQi5a7oJSyaShBhHL0JcBejysvHPFHmJXtBPvmR5AJogWgCF7iy//eSEYMM0POJLWZEGAXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fHmWgz86; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390eb7c1024so2853551f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 16:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048471; x=1741653271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9I2Z6bR8zx1eteSpHnDKlkOmZth6MLuc4W0LAKMNv8=;
        b=fHmWgz86WKdrACF8U+n4fOo286DFZ5kvnI5F4bQSURyNPk+c8oNf4OYHMOExGCXnzR
         ypmp6zuV4L/FxY4ne/yT6Oc89jDvDuSjLlSBrK6pAwyAJRWklbm/9bL47njZka2qLxFA
         XTJKvCDynygQejmCd5o0BmZC/z/gHjgtwc4taJqmSZKfnV8q4rF+pnZf/745fHwehPzF
         684Hz1BH+7tAfjHzupzDGYNVglHh8Oc7CCDryvEqVI8qe64v7ggFO+53b2WLKckjQVm1
         n5xyEqBvY/h/r/OHFjRDIRIHtOH/KKwgwxiirOCY4ii558N7dOf3izEJtWVQ+TQknsbp
         DyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048471; x=1741653271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9I2Z6bR8zx1eteSpHnDKlkOmZth6MLuc4W0LAKMNv8=;
        b=Tcbc0aH5tY45HqmhXqid2lUsSzOI62aThYYW4TYbLbnVDiJqfKJZt+7Zv1TeoiqlF9
         pTHEB70lr8fVG7dYRNX7b0jeMv56wThjd01sR01kB2xpWXR/vRgpkYnaXzgt+9MgtflK
         1PUwyTYyHBMr7fWADBWpeGRcqgKOVn1LAaK9wqmjLM4SfUxRAc8mhxkoE6oei+SstI8E
         qRx9jIwJgKVlJFCDYwHfKr21Ugt+JB0c0l5Yn/sRX/yccUh0MtallLdIE62GIm7KawSL
         qnSMglHtFKEafH0o212sBizXcspTNdmC90Ih/I+uaxCTZhqVghTdBeZnoZyxsDi0GuoQ
         Yqcw==
X-Forwarded-Encrypted: i=1; AJvYcCW8bq2TxgG50pR2C9VzdgIpw8V+mEuzIHxf3NLaTewgA/yhEd+TY3Tm3Iu6MI8Oh0fbiIkg9od6AmOloFqcSZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHgwmAVrCyPWi/JEIgnvz0F5Qdu+qCYuXJ8Q3ejcY+wN0MxPUn
	gm1FiYy05HAfDHanGbD8onGf5neEnP5Cbg35itTyPFlAkIoEyO33EElDPhHYVIY=
X-Gm-Gg: ASbGncvoNcd5sfpfXPKoYGK6F+C/twxNdrS31DPq5qnfXAfYJJJfhP/Ta2lL1cyf7C+
	eQW15Fd7HFOJnEeVOc09vHsiZpBEpuynz1AFq9xqdb5gO16zK/rd1nn8NrUCKZnMnVXcfq7Z1Fn
	s2MwrW0CjDe/HcWE7R00x7hrpmDeDGhh7I8HHbGi4hETL4bCTNVoUub+OsObB2582iKfQugOKsQ
	ZaTVn5MOqwKBPfg+Cjh6qm1t49JxUgTfpYpIPDD7aGHQ4Ki8l8IkvQonEW0WpR0X09fRsHzeRSk
	MyLLCADzTfDZBp9ziuyhU1YxeHMKWV8SZFZTpVJyaQ==
X-Google-Smtp-Source: AGHT+IEHKKAGAd1BjILOXEzGWz++BEzbTO6UvfRsSajZRH+vqZG7TH7Oj0Jq8rQNbGDjEUn1i/p1Zg==
X-Received: by 2002:a05:6000:144d:b0:391:8a3:d964 with SMTP id ffacd0b85a97d-39108a3dcf4mr5634205f8f.41.1741048471577;
        Mon, 03 Mar 2025 16:34:31 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:31 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:34 +0100
Subject: [PATCH v21 04/24] ovpn: keep carrier always on for MP interfaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-4-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
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
 h=from:subject:message-id; bh=/xvou7dFKioksUHeuOvCiwiW+/ZP6NzsNB7blkKp/EA=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqOiqtup4/iW4MUmgJD/JzGESLgHkMMvlnBe
 lZiJJs0QPCJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKjgAKCRALcOU6oDjV
 h9gDB/4saE7fWQx/F1lE8cYzb/KDXp1q0seba4+yMg6PT0W+V1ZYlx0HqgT06ZRO75IVNsRuALt
 StrqVCU92RA+XYs3L3CxDoK3EC2qzPWrI0JOe/Xp+guzys7+lO1PtAQxpJ/J0zP4IblX/+p6Tnx
 lKf9gai+bBO3+gUj3m+Adhs4j2tLyssocbxFoJcQap98f9szyztLIw1xgACdSp2kD15I3cyVGhi
 0g82Au5aAcVpc5ive9gdWndTmdZ2XZ1Mw/hAYErjupAVsBuAT4FfXXBeOH4NfihTKOEb1ET0Dc0
 kmfa9++9FN46ekTuaen2mqPqMq+uWt0WFv+RWCC5ZGayfazV
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
index e71183e6f42cd801861caaec9eb0f6828b64cda9..c5e75108b8da5eabde25426c6d6668fb14491986 100644
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
2.45.3


