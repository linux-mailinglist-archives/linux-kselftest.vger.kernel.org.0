Return-Path: <linux-kselftest+bounces-49257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FAFD39462
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 12:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E8DA303F0DF
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B8732B981;
	Sun, 18 Jan 2026 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpbP/0VU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4597132AADE
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768734038; cv=none; b=gIErqics+Ky3Ql+LnzoCkkJxhb2YpaN7bJPUD2Dz2pkrMFPqKWGtRHWUdhCxd9/qI7B2m7vudKoODd9AR8n3vGgh0wQotYjaoJ9f8YPS7zwgYVF8JNT+oSCt5PI+OCubKWASgNDk85l6TwhLgKqyTDrTbOtqwUgN7D69SxdSbOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768734038; c=relaxed/simple;
	bh=2IR9K9fFwUyb3vK1T1dQvAvM/jN1tGrfN72mQMj/cpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1xGsvznrlVi++eri7qEn64TVOrsKnRFRPc6cQot9BkYJ6SPPSsDbrVXiz98+YEE4Hwsc4XlAXLts6FHKbf6v+OFBEFaUaHCLewnLUI/41mDSKQrtIEWYto+Ux+hyICGpRLIwg2bEwiYgrBPzh4rdaHxbUdXTXzK2GTTZp2PgWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpbP/0VU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801d1daf53so21259225e9.2
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 03:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768734031; x=1769338831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZJpugnwNeH6pltmuI9tKkzaUCo5szMqMArK7fNoASs=;
        b=gpbP/0VUM7wN14tUSOCRuaNj7g8IhqrWgy1uMClUU6YkG4NEaitoH3D4DyU/Wmgxuc
         X7ZSKLRX3OvJ7rHjfYhP3vRUSJb9BhDm7SruURfY+wUt2UMFtPFDbDYkJtZWjVGPXjxG
         JnJXrjGWMm+SaHN7rIgGIbCGDvV+b80VtxnqwpFP3qL9J69WwIGrkh1wJRwrIrpRQJAJ
         zBSmXlkfqG63iuiz4auzsKAWCYi+pjyL54HEwaJC1nFnuM6HERnRVBQ17/jC3EL4lCH+
         FVNXWMy7bifrWlg6btew66qssPs8KmUelJRVg8rXgzdHKawaEZ5bJJEjoVJKpGQJkVYf
         urRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768734031; x=1769338831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ZJpugnwNeH6pltmuI9tKkzaUCo5szMqMArK7fNoASs=;
        b=SuDByUsDpVj2RV5I2a2mGxYUkvULdRy2vmUUAciobGul88K9GjFtK734nbSMvxQeQD
         8zu3riM8DszbdkwU707ygfpiKMILiJ9ndIGBSt9+FtFa0MZQ9NHVtdC2M9bzYVEu76Ug
         /BRvJ/BKaXXRdsaH0GWNdFGvSXt5Ck/7L4mHP1gofFeftPj1mSAX56s/soaiNXBVT19P
         /iQrW1QjHDIk9Y1PASNYIb84jvKVwSLt0utWHIL6p9Hjd1bFHPBg5fd69MMvVFu9VZp9
         MzDHnSU1g8Vf3oTz+iB7QIacry4Bw41rJBX9x8ZT3xg1ymqR8D+LAqEfgYIhTjqh0hXE
         JKcA==
X-Forwarded-Encrypted: i=1; AJvYcCW0YevhF+YMftRjz/DnGyZwYOjanRV0zNzOBOS6dz1eA+H8w9cOypx+8onnkNRJJn/yBNhESpNgEJQQGtXIlZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyqHgk2j2dyPJ7ePuKFzeAFX4v/H9IVttfz43M1gIsTu80t/lM
	Lb/+hZ+oi/0YKvqlcsacLVwgHsD38WuS1IW2ynZW9gBgzWwxBlvhom9w
X-Gm-Gg: AY/fxX4USRoxa5flu8onh/Pgu1ZuN6chLiE4cy46Ng/kBQdAbvkW7KdmoxidAYgYjtv
	G5dsKvlLw0EATJVG6rtL9SY4bVQ/JL9kc8sK84bAvVBh5VTlMAqToyu4lQlOVI1EyQolztvDvH3
	z/cmUJheGb9v4bTEmUIYujMxDQ3LPlKdjCEsqNIhlRenD4G4h121Di6DkSqFZK1DXRXKzyQXGst
	OZ5+tlLH2jn5MgS4TeL+KZOnZz5166pfYil3T0bMd5dyTulL0+ISrlJI7pJ9ApmKAMvuN8cRoDR
	O7DmlW6hzn9QFDGcHlZD7hXLFuUNYG/R5/iIR+kVwwfwYUdbgn+nKAyScYFLvexoZgdUyksAGrh
	M/rqFDPAcTJtiyHTyHIIUEzFx6AqbQzlDh2jA3bBXnpnurIy1XJGr+Vxzmf6IihvLKDktM5uE0k
	hgFD6HBgaIJ4CulQ==
X-Received: by 2002:a5d:64e6:0:b0:432:dc23:34f with SMTP id ffacd0b85a97d-43569bd0b90mr11399255f8f.53.1768734031192;
        Sun, 18 Jan 2026 03:00:31 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992201csm16864635f8f.2.2026.01.18.03.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 03:00:30 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 18 Jan 2026 11:00:24 +0000
Subject: [PATCH net-next v11 4/7] netconsole: clear dev_name for devices
 bound by mac
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-netcons-retrigger-v11-4-4de36aebcf48@gmail.com>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
In-Reply-To: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768734024; l=1518;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=2IR9K9fFwUyb3vK1T1dQvAvM/jN1tGrfN72mQMj/cpo=;
 b=ZvsPAc1Nu3ncrw9ojdKCeN2DHwyPVw7plQa3n07vRyJd/cxxaUO+SA0AoD9lL2k2nzwCszWvh
 nW9AXxX1gTCCe+wxKObWzHnTXE+T7uhtZbLMIQUgtk/NLL5m5Yo7t1D
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patch makes sure netconsole clears dev_name for devices bound by mac
in order to allow calling setup_netpoll on targets that have previously
been cleaned up (in order to support resuming deactivated targets).

This is required as netpoll_setup populates dev_name even when devices are
matched via mac address. The cleanup is done inside netconsole as bound
by mac is a netconsole concept.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7a1e5559fc0d..02a3463e8d24 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -242,6 +242,12 @@ static void populate_configfs_item(struct netconsole_target *nt,
 }
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
+/* Check if the target was bound by mac address. */
+static bool bound_by_mac(struct netconsole_target *nt)
+{
+	return is_valid_ether_addr(nt->np.dev_mac);
+}
+
 /* Allocate and initialize with defaults.
  * Note that these targets get their config_item fields zeroed-out.
  */
@@ -284,6 +290,8 @@ static void netconsole_process_cleanups_core(void)
 		/* all entries in the cleanup_list needs to be disabled */
 		WARN_ON_ONCE(nt->state == STATE_ENABLED);
 		do_netpoll_cleanup(&nt->np);
+		if (bound_by_mac(nt))
+			memset(&nt->np.dev_name, 0, IFNAMSIZ);
 		/* moved the cleaned target to target_list. Need to hold both
 		 * locks
 		 */

-- 
2.52.0


