Return-Path: <linux-kselftest+bounces-46033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2933EC71868
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 01:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF3124E2C6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 00:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C931D63C2;
	Thu, 20 Nov 2025 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDyG4RTk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1056C1ADFE4
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763597735; cv=none; b=Hhd2EFbe1dAdwhWMue7YloNm2HNGv0TryO56R2DcsOrTTp1X18d6L+G2C71c5sDRNZsj9xXb3UMs5S6JgO7Rb+okWlmMNWJyx+R4QJHfjmK2+fY14f6Hs5PZJxl/6vCpEZgUHRKdoDW7Q4XVO2l52/TWbuYWNblCe9tmgj8Vc/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763597735; c=relaxed/simple;
	bh=OJ5QWhtiskGythM7vc6Jd6M853ak+vqQdxx02P1aSSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f7+r32gFA+8eFwArmEvvKI2+P/E1laEEuQbYz2aGZkLJ1zv7lABWVhxeKFc0K1r5ucfs3n5udnNl+Dm5ooVN+l8Wd+WeztwkOCTcR9RNXNJOyTWbKOl55XQDKz+64l/iGM3cC9O/8vCdVz1Wquxg1pAPa6BaIpkIFEZqHMuz3NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDyG4RTk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779c9109ceso331265e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 16:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763597732; x=1764202532; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SayxfPvE/g0bojag9Jh1IjbEk4cTOITTJ9rniJCmzdw=;
        b=MDyG4RTkla1NVM2/ZkWxecCIwg68QHNaq5SRT2t3FXNxMMC92WvTSSGn1hgcz68pCl
         7q1tmID5BPsVDC8Dy6yG9tdClOV+c6LjwNAr4DkSyCr1arey10jrRVcASfJAMNh3YLed
         VwWFVph2PH6I7BWQZDmQhWYT9/vWS3kBE0q5c/sagrGv+WJc5h98bW7MlYBmN9PDAR+C
         /2NkFmgdlIKPfLv7HgZqaYjMK4FcpB7kKC9JEfzx5WaXRLhhnCIE9H+rZwlM90LceYvh
         42aCqzSrAwxG30cp1dzNFiHlJpgHtbMcHGSmyVVGdj5HAJlwFsug/ZE1CoAL88FEFEIJ
         Kfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763597732; x=1764202532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SayxfPvE/g0bojag9Jh1IjbEk4cTOITTJ9rniJCmzdw=;
        b=lQ4UTCr9PpUncE4pZNEXEfFfWPEl6S1u++SUfURCPOU7vxME11m22ESdrurS4Wf13o
         1GlP7dR3R/CMKPfwOeptNsdqk6oH7PifgLw6WIXIrt350Dc7+FKsJYPRyy5UF8JKwt5f
         zaJzz8+PcCxlNdVCXsR4M4dixuPNhat4lLZj56YjR6tJzBvvPynlR58dYogUTio0TYtu
         u8KDCpks61xDRY4wK4ookhmO8BS2qynMwXIKcVildvmfA9PbDY2WoH9TCFSPb7inHwTg
         VBf40p+DIA2hDraLaUVgdEZf7BTku/h9jA+ZWp7+uuQBUJpKuuVzZuhbEIvxS4DKjh+y
         4rwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEF1yz+Z4w9OB0IH2jZl3mVXhTP+tnPck/bhpk56Xn4VVbbCDDn4kX0Siclt93iGjNOZC772jIe1unhTyXNno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNOTfgOcazksWlhe2ANkMggst3s4w0yNnyCXBNjjHHciHTZhkA
	j/9qOMmooipPOYBGNjQFwL9MQ/lBpOub9ZMzhAJwl6HtH0b0AREkx1b8
X-Gm-Gg: ASbGncuK6Cc93hGX3Q+Po4fbAyWApOZX+2aVhsezDkLpQl5fpoN0OOkZB8giGYvZGLb
	ENvMY+o4a24yJmt/4NFsZGidwl/chlFwtBNk0KmHl5B6g5+Sja8I9du4/yBQGm+nBzj1ZvjIMyj
	KWbN1n5mkKeC/YIv9ss6SqSLsp8nowO+7AYkgvP5yAqSKpvUgI0RkCTgE3P4VgvewATrPjqZvrQ
	D7IH/F0Adp/81Wflm/3vEVuLts9RY6tVHyjLbO0drSK1J94CsN8HvvHYW3mVfy8LHBLN8j406e6
	Jn+wxIXbXVYGiHy3JnQFodPFNRnpS00kiIrN0k+WLMGDlkG3YJjftqe4pxnGOTAwfjZIrOP3EFG
	9IuKlqBRe7LqE+efK4PRTesG7FX+1rXY7MOB+L3rbLKrFh8yc0dv0yMFNoZxjzKy+NwioJj9Lce
	BE576Dras1qERi9H0MrQME6Sn1yMxQkYCoHANZUQ==
X-Google-Smtp-Source: AGHT+IEzBZnPtD+MWg+C98wu/ohpL3j6Un+ABjFCUid0HHBT6AkRjqh+tjh65yJWqV45+5XdzYdJ2Q==
X-Received: by 2002:a5d:584f:0:b0:429:bc3b:499d with SMTP id ffacd0b85a97d-42cb9a6a91emr262740f8f.6.1763597732189;
        Wed, 19 Nov 2025 16:15:32 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:43::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e574sm1897907f8f.3.2025.11.19.16.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 16:15:31 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 19 Nov 2025 16:14:52 -0800
Subject: [PATCH net-next v3 4/4] netconsole: Increase MAX_USERDATA_ITEMS
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-netconsole_dynamic_extradata-v3-4-497ac3191707@meta.com>
References: <20251119-netconsole_dynamic_extradata-v3-0-497ac3191707@meta.com>
In-Reply-To: <20251119-netconsole_dynamic_extradata-v3-0-497ac3191707@meta.com>
To: Breno Leitao <leitao@debian.org>, Andre Carvalho <asantostc@gmail.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Increase MAX_USERDATA_ITEMS from 16 to 256 entries now that the userdata
buffer is allocated dynamically.

The previous limit of 16 was necessary because the buffer was statically
allocated for all targets. With dynamic allocation, we can support more
entries without wasting memory on targets that don't use userdata.

This allows users to attach more metadata to their netconsole messages,
which is useful for complex debugging and logging scenarios.

Also update the testcase accordingly.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c                                | 2 +-
 tools/testing/selftests/drivers/net/netcons_overflow.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 0b350f82d9156..9cb4dfc242f5f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -50,7 +50,7 @@ MODULE_LICENSE("GPL");
 /* The number 3 comes from userdata entry format characters (' ', '=', '\n') */
 #define MAX_EXTRADATA_NAME_LEN		(MAX_EXTRADATA_ENTRY_LEN - \
 					MAX_EXTRADATA_VALUE_LEN - 3)
-#define MAX_USERDATA_ITEMS		16
+#define MAX_USERDATA_ITEMS		256
 #define MAX_PRINT_CHUNK			1000
 
 static char config[MAX_PARAM_LENGTH];
diff --git a/tools/testing/selftests/drivers/net/netcons_overflow.sh b/tools/testing/selftests/drivers/net/netcons_overflow.sh
index 29bad56448a24..06089643b7716 100755
--- a/tools/testing/selftests/drivers/net/netcons_overflow.sh
+++ b/tools/testing/selftests/drivers/net/netcons_overflow.sh
@@ -15,7 +15,7 @@ SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
 # This is coming from netconsole code. Check for it in drivers/net/netconsole.c
-MAX_USERDATA_ITEMS=16
+MAX_USERDATA_ITEMS=256
 
 # Function to create userdata entries
 function create_userdata_max_entries() {

-- 
2.47.3


