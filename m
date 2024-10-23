Return-Path: <linux-kselftest+bounces-20478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D689ACF3E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD221F250CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB0D1D042A;
	Wed, 23 Oct 2024 15:44:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB21CF29B;
	Wed, 23 Oct 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698256; cv=none; b=ZYHw70UHZtsWp8cESAzq4TQ8FS79+5KglPB9g9mZMLQ6M9Dj5Dqtxdgpo9QDZpR6DneLdsAs1EzjtF3Y+4ZTkb/JpnRim40QvMLuEvCSAQzEoXvXiBulOQ5J4TBHy2uvU8WKGlBlN6RViw35izpNChPfg4KOuDpZDVD7+Z+hOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698256; c=relaxed/simple;
	bh=og3zr3saPqbWT0VxgUJgzCO724Ye3nF8hiqLbYRm8GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kljNl++jV20AYlBxbW1qXisLNUJUuD+8ISpDVL/wVW85t1JRoW8qNknQ/Cawa4L6AKWcWiAbCRl1sW16V12g+lYikkL18XzptV9zPeccE26OwkvEI43tdOwklQQow+5vt8v6WJRZ/eI0hHb4UUXbHJT03w66eV7/h8y3rJve+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c9978a221so79248605ad.1;
        Wed, 23 Oct 2024 08:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698254; x=1730303054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+bp/FLvuQ/H/YT5HFz5uDgTntUpplmekx3z9WyNTng=;
        b=PotNYE0iIrpsv9bjxex0Ld9tmnaM3qEVPCQXoQEs9nzVc+TO+YlTQUh+nX3K6Menut
         uLvi6x5JPPoX/7OsO09MOaf8vTDRh6Jai5TG3p9cpa3z7kXE05pSB4penHI9+KpZMP7F
         hB/Gwi4wbGZyv53GbIlKJ6TmTTgUkluj2zlJG9v+3uyLVvheOGBfp3kgUB8jP4USnQDC
         qoz4JroHxDAr+VS/Q59LgarWmfsBfhcGl0ys7AkaWPkoqpjFCPlcHB52k3Jfint7ahXR
         QFxS8EVWEzk06tHnrpjIlgJv5oJz+GW24A8qOcBVo58dDQWbx/bXGDM5p8vfkBbu1XK8
         cW7w==
X-Forwarded-Encrypted: i=1; AJvYcCWRTSTfG5ic7jnZKUXCH7TPMFQk41RU1xowIvtIn0fwZ1me2ia71wyEXYOdO7xoDPE6sSzcl1eQNOv7a59sizZZ@vger.kernel.org, AJvYcCWp8W6zF84k6wxlOoUGfCXfTNzvD5EQPhelp7d/Qqfq/RULpw6vN2AceNb1V/Ati1pmOzgOIdokbm7nFoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG0z1NsTPLymMM4BVM4uAqa7TR4p3Nx5KmYtwg+K2GbvPiUBQQ
	cSOTUNOLGC1ZI8v5azMCGUMMPeNmKOmt7lrQ0eNQtWr0gumylGIjk7OSz40=
X-Google-Smtp-Source: AGHT+IEZZfTmueaaco1d83ZsWoO2wNzZMdh/1WHP5mfohgQTgpDmlHwPVGqu0yQE6IyB3z0LUC0M/A==
X-Received: by 2002:a17:902:ecc6:b0:20b:ab74:f567 with SMTP id d9443c01a7336-20fa9e7850amr42005405ad.27.1729698253715;
        Wed, 23 Oct 2024 08:44:13 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f104ac1sm59113725ad.299.2024.10.23.08.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:44:13 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v5 09/12] selftests: ncdevmem: Remove hard-coded queue numbers
Date: Wed, 23 Oct 2024 08:43:59 -0700
Message-ID: <20241023154402.441510-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023154402.441510-1-sdf@fomichev.me>
References: <20241023154402.441510-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use single last queue of the device and probe it dynamically.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 40 ++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index e1faad46548b..fe4d81ef1ca5 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -75,8 +75,8 @@ static char *server_ip;
 static char *client_ip;
 static char *port;
 static size_t do_validation;
-static int start_queue = 8;
-static int num_queues = 8;
+static int start_queue = -1;
+static int num_queues = 1;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
@@ -208,6 +208,33 @@ void validate_buffer(void *line, size_t size)
 	fprintf(stdout, "Validated buffer\n");
 }
 
+static int rxq_num(int ifindex)
+{
+	struct ethtool_channels_get_req *req;
+	struct ethtool_channels_get_rsp *rsp;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int num = -1;
+
+	ys = ynl_sock_create(&ynl_ethtool_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return -1;
+	}
+
+	req = ethtool_channels_get_req_alloc();
+	ethtool_channels_get_req_set_header_dev_index(req, ifindex);
+	rsp = ethtool_channels_get(ys, req);
+	if (rsp)
+		num = rsp->rx_count + rsp->combined_count;
+	ethtool_channels_get_req_free(req);
+	ethtool_channels_get_rsp_free(rsp);
+
+	ynl_sock_destroy(ys);
+
+	return num;
+}
+
 #define run_command(cmd, ...)                                           \
 	({                                                              \
 		char command[256];                                      \
@@ -702,6 +729,15 @@ int main(int argc, char *argv[])
 
 	ifindex = if_nametoindex(ifname);
 
+	if (start_queue < 0) {
+		start_queue = rxq_num(ifindex) - 1;
+
+		if (start_queue < 0)
+			error(1, 0, "couldn't detect number of queues\n");
+
+		fprintf(stderr, "using queues %d..%d\n", start_queue, start_queue + num_queues);
+	}
+
 	for (; optind < argc; optind++)
 		fprintf(stderr, "extra arguments: %s\n", argv[optind]);
 
-- 
2.47.0


