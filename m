Return-Path: <linux-kselftest+bounces-20930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C6C9B474B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 11:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F294B22C4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E616206E60;
	Tue, 29 Oct 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="aca0Fbvp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F66B205120
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198890; cv=none; b=SbEixdTgFKhSZqnHTGR94JCq8UDh98nIOF7YKdwY0iFnpZOej5moHdnEe2jjC492zUWxBPpX5a4P9PBak/gk86mnDhFaI6EUHyKWhNInrj4QpButjMGSSWXMkJlu2qQMMlb7mvl4HAsiHdaSjkIP4v7mAVy3PnK7HrM9NVqjLqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198890; c=relaxed/simple;
	bh=fdzF3OOmoZvBMLXtUajHYKsI45JNjgatz8aXU4UpXD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPQLdo5rN3kzufUKEKX5oFU/9L1E57HqbiLIysBg8V1cju9fWHRKHFJQTGaBaSOeaG5gUn4gq8h57VOnHk4QKkep7p55uTS6Jd55FdZjOYQvV2uug0B433w3O1NAkuKcAM59Wpbe9fyrdyWV/O/68yGe4osfjwaptCCqKWfGG9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=aca0Fbvp; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e6c754bdso4739877e87.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 03:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730198885; x=1730803685; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbrFnZJaX61MB7xNUng7QgrtBfqDJUowzpqh7fH2eTs=;
        b=aca0FbvpB+P3Q2Mzjx49OxS2UIcx0tgpUke4qVxuALCAlr4kVEWSeaLJ3I10LoEPbY
         AzHlZQeSRFRtaXJwDm5IP6nn96NTJBhzmnDihjPsSFVrLCb0d9nPKmUsDwUCZTMYSGQa
         ErYxvMlkxUcK1elV7atO19EPVn0X4T8d1DSN5xxMy2fw2IxJ4t8qrUdroQbksp1n+eWw
         xRpQVghdwSuNg8hGDar8pyp8Gws8RB/otE1Ezx/G+6dsphsTKd2JTFg4s/EXMtgQh6xT
         2uZfTqW9IgML5Wr9PYjFuDg+qwSAZGcyy/bWb1KvegL0frCmYfL/DMFSIsvaIXz6rVbk
         iXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730198885; x=1730803685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbrFnZJaX61MB7xNUng7QgrtBfqDJUowzpqh7fH2eTs=;
        b=mkoXXFYqybJvRndOVrAtnNo/LigEeezTuobinRuVk1CCXrcziLxrSteMXqGBK1YgMZ
         Vxr+mW+snasyRFSR1Df/lIpI/IIgf2dDXMuqWpCVhOg0j8wjsDsDBpmWD31gwRLEu9bo
         pUAxJBVJd7fWS79LMeKXrTx/1zfKctp0nuoJq93Aywa63EVyj9T4P/5xOOGCu/t/E2/3
         eemRvkZ+PwUexzc76qLTTF3tltgEc31OYRypXF3lvIa9NMowktvXc6NGkoJQeNOyiRNH
         C/mMqhN45fTN7PIQSE6spZEGmdopuw6ZUoh11ph3IVnCXJVFUqmLF16/FWte3C3SY7IN
         okMw==
X-Forwarded-Encrypted: i=1; AJvYcCUCt2FrhIBbsEEklE8Rr6C0590l1lb7n57X4mlMLDUnQm+Vg3l8c0PUmAePEiysuZ+7C1oRzuW2tpiO80viB28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBSkL0H2sbQnnFQI7NVBUVjkVPV3xQqzd/RJ7nPmUQ1XDhxGHf
	16xWPpWJ8A1gT1B8WlsWkNAIoAZPPKSSXlNsNqJcChVVE8x5OtSx0vpWrhWOSuY=
X-Google-Smtp-Source: AGHT+IFHm1oxARIH5YtwKkd2Trpp3h6YjvPpWbcHY9fXQ+7ZD+Y9YN+0wivLeLUYA5WTvdyod1Xxvw==
X-Received: by 2002:a05:6512:1114:b0:539:f2b9:560d with SMTP id 2adb3069b0e04-53b34c46657mr4667262e87.61.1730198885229;
        Tue, 29 Oct 2024 03:48:05 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3dcf:a6cb:47af:d9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431934be328sm141124785e9.0.2024.10.29.03.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:48:03 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 29 Oct 2024 11:47:18 +0100
Subject: [PATCH net-next v11 05/23] ovpn: keep carrier always on
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
In-Reply-To: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=fdzF3OOmoZvBMLXtUajHYKsI45JNjgatz8aXU4UpXD0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnIL1qRZQMYGM3Uf3u8fZw+RkNAoGf6eHWWjfLE
 Imol8IfFACJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZyC9agAKCRALcOU6oDjV
 h/C9CACr3W3IYO6jCZlUCsZVolbkRrR7z2oOK7d7vHVof/CULBZgy9E+l9aic13B77UCULpeHRA
 Zp/otDN7FCxxp1D6scbZP7tBFLBF9lXurFyLlkg1Zf1Mnmgtz0xnQuLCLy+w5WsmheQlxiDEr5r
 TqgvugvnhcGUFpdbZNMWtUfuynOmaFDUiFKUPZ32AYY5v1u5ZXRCdFWLESvxi9zbMNKlLUkDiUi
 7BkJsxdQl+tN4wdhKtSEgpAdo0BeeLMP0HNQyt9hNiFhO5BbdbvdjJtEy8FdXZxRrtr9ERyceGl
 35X+QcQuU76d8NcwyxCuh0k/fPjEzhaV6ay9RgM8qsDXRIZB
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface will keep carrier always on and let the user
decide when an interface should be considered disconnected.

This way, even if an ovpn interface is not connected to any peer,
it can still retain all IPs and routes and thus prevent any data
leak.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ovpn/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index eead7677b8239eb3c48bb26ca95492d88512b8d4..eaa83a8662e4ac2c758201008268f9633643c0b6 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -31,6 +31,13 @@ static void ovpn_struct_free(struct net_device *net)
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	/* ovpn keeps the carrier always on to avoid losing IP or route
+	 * configuration upon disconnection. This way it can prevent leaks
+	 * of traffic outside of the VPN tunnel.
+	 * The user may override this behaviour by tearing down the interface
+	 * manually.
+	 */
+	netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }

-- 
2.45.2


