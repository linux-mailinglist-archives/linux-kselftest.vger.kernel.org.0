Return-Path: <linux-kselftest+bounces-43776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E92BFDA4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 19:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587CB3AF12D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609E42D661D;
	Wed, 22 Oct 2025 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Onm42/E2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF62D7DE8
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154840; cv=none; b=pgMcxpHSGonH1Lb2Am2jnDYC7ETL5cVpfQTH55zbtN+5TWtMteN1Ix+rtGN+DW2/5gajYXYfGf47Y1HHrWTK4SvmRB9a7q3tR1vMKcNHcIV5E7jY/sS3EhtFlvYQa4CTiDESxpjCPrmQrzMCTjpWfWowBDO8+MgpCBThHZELZlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154840; c=relaxed/simple;
	bh=oCR56LMNxbJLVPpG2Gxtqc3kBZKa3X3HExddSDRVgK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBbNTRIptXvG6bd0/rr5TcWJ9UyoPDSZeuVG28hpyD1TEy9Nbl1LacMm8PgGReqfIqsQyrtPBU1kfz2msOWm0v/LLg4Egwyx5w9dPV7aM0FJuSAnxsybNlezp2I4y1/fVhCwBhrBIE7bGbPYIhh9M8Zzc45KPbPQtGs3xfje9lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Onm42/E2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-427054641f0so1095708f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761154837; x=1761759637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgD0EgpQ1bwVIze+M9LiD/EeIFj+v/rXiYxks5RmUv4=;
        b=Onm42/E2WAA2X5zZc8PppDnA95yZwMbtpY1ZbVP0wQQLjLj7hr0CpCQIYvnfsWRheY
         lxSxR9FrjDdebES6CU7ItS/pi2AowBTxs46onppnlSnY9n9M05T1p7hj3PMtAUm8cIYJ
         zIrXOLnvYewJGtpZP9cViO0P65/DrOsozKARRzZuE7eI/cTpBbU2wKghG3vdy24FBoZF
         t2e/fPWj5vLUaJk9qpRRkUj8m1vhmFtnesFuhtu2LhOk5N1Tk4eH2avCu6+od5bEu2/w
         MNZHqDxXgv6iia996rZ7oPvdDRxI98HGYvw12oCeAMVcUe77P+CdwOPmRkt5mNU5in/A
         OJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154837; x=1761759637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgD0EgpQ1bwVIze+M9LiD/EeIFj+v/rXiYxks5RmUv4=;
        b=kkrQ6B4xbvttnVaumYcukc3R2IEDa5RbAyZa1/BvPANatUwSNoX/CRxy0T8+d+ndp9
         SDGJHxJbPy2OFXTJo3t3acwPqbJJQoFgZ7tIDDDMkW8ReAxr6FmotPs6F8xKGvd0LQr/
         WUD2QOzB1avpNaJ56kZXZCbqH5scCx8aERjYEhc5WZnwJ0gjqzZVtQ3mf6UAFfXboKnE
         XimA0gsAcz0l60fHnWG2ftn9O2wWKn/Lj8lA8G7IntvG0EFKQ5fXTxBKyRRwUEcDwqSk
         X/6wKXH64Qg33Q2bkyRWm3J72TVVUMu5E4II5c2XRZNjIMNN6LEhWdJXA5Y61rd8yNKy
         n3gA==
X-Forwarded-Encrypted: i=1; AJvYcCW1cN3b5Esfon3E5GUX/GmmwD2p4eDvXcldqn94OTrjLxtqz760370nAiqdYInYF9Wvgm5gbi5lFq6KiDV9UzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyemQNpHgxbMVQjUR8Mf4Tb4T7Wc8md08D6r6QEX1RqUQuYZsv
	z//zz8o17Foo10fhfAG8M1L+Clj/CgcQ5I5K8m1/8gJF62TufDjKxyC2
X-Gm-Gg: ASbGncshbpjqFuaCzXJwB7Ytax+gzZUNp/qjT3vaRIQAEOTmjNvuAowopa1VA0JGdxW
	jrm8F4tlFgT0Dvft92PHVczXnpRDmYgawm7/xw6kCucHz6cmWEM9AYhb+Bfeg7F83/FhfqtoCTK
	D0NKlsv8kENMA3PIzMGKNMgzDthNXvVp5+L/7VG0F4rHZJ93sI8Fq3Vl9f/+j2LwwW8dBs4alju
	Scq+q4wWX7VhAUmA2H9wJ2xY35B+oz0RJVlm9PCEdjAke0nVWXTb7JBc1J8GZwgIa7IOYBS9vP/
	yXzx5n6xMoJqz3gGTW38JVa6SflbU1we7NFQWeqYWQqxJFO8NaA6Jq12WLihaOeI/sNT7xZikSZ
	zc1zoQVmM3J+5nszsgZqYvNft1fqRXv/slpBHsP0vMQ5029wIXSL20lzzWuQmcb4FGV8Ag7oRNE
	q/4taE
X-Google-Smtp-Source: AGHT+IGo0Rt1P+fnF95QCjRY9TTnpGTG3b3OqZamIFsM0FWgRiah419XNsZpM4zjKsCv8BLdL6naAw==
X-Received: by 2002:a05:600c:1e8b:b0:46e:36f9:c57e with SMTP id 5b1f17b1804b1-47494305991mr35917595e9.5.1761154836724;
        Wed, 22 Oct 2025 10:40:36 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:47::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-474949e0a3csm43661225e9.0.2025.10.22.10.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:40:36 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 22 Oct 2025 10:39:57 -0700
Subject: [PATCH net v2 1/2] netconsole: Fix race condition in between
 reader and writer of userdata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-netconsole-fix-race-v2-1-337241338079@meta.com>
References: <20251022-netconsole-fix-race-v2-0-337241338079@meta.com>
In-Reply-To: <20251022-netconsole-fix-race-v2-0-337241338079@meta.com>
To: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthew Wood <thepacketgeek@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

The update_userdata() function constructs the complete userdata string
in nt->extradata_complete and updates nt->userdata_length. This data
is then read by write_msg() and write_ext_msg() when sending netconsole
messages. However, update_userdata() was not holding target_list_lock
during this process, allowing concurrent message transmission to read
partially updated userdata.

This race condition could result in netconsole messages containing
incomplete or inconsistent userdata - for example, reading the old
userdata_length with new extradata_complete content, or vice versa,
leading to truncated or corrupted output.

Fix this by acquiring target_list_lock with spin_lock_irqsave() before
updating extradata_complete and userdata_length, and releasing it after
both fields are fully updated. This ensures that readers see a
consistent view of the userdata, preventing corruption during concurrent
access.

The fix aligns with the existing locking pattern used throughout the
netconsole code, where target_list_lock protects access to target
fields including buf[] and msgcounter that are accessed during message
transmission.

Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 194570443493..1f9cf6b12dfc 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -888,6 +888,9 @@ static void update_userdata(struct netconsole_target *nt)
 {
 	int complete_idx = 0, child_count = 0;
 	struct list_head *entry;
+	unsigned long flags;
+
+	spin_lock_irqsave(&target_list_lock, flags);
 
 	/* Clear the current string in case the last userdatum was deleted */
 	nt->userdata_length = 0;
@@ -918,6 +921,8 @@ static void update_userdata(struct netconsole_target *nt)
 	}
 	nt->userdata_length = strnlen(nt->extradata_complete,
 				      sizeof(nt->extradata_complete));
+
+	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
 static ssize_t userdatum_value_store(struct config_item *item, const char *buf,

-- 
2.47.3


