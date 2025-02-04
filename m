Return-Path: <linux-kselftest+bounces-25666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FE1A27062
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 12:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE007A2FF3
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48C3210F58;
	Tue,  4 Feb 2025 11:35:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C661C20E007;
	Tue,  4 Feb 2025 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668940; cv=none; b=vEZaF4EjUDI72eU6kB481O413lC2jAxsp6JgntSTLwEhAIYY2mKJZGgP4jJKs43Hgkk2OOa40vgQMPuPuofuRYK7P2QKRAZozurbC6KWIZHcHNbr04+PRAfq1Dh+KCEq+pyL9mzVMMPfx5GN17Af4auKU0MXQGfMLRzVhxLO7UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668940; c=relaxed/simple;
	bh=TDqC7fD+fxMAo8/7y/hGgVVgkOS2xRk3o0bFxnvFUdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lljq5Vkx7fdvCFYhK9s0HB20EKu7mOuEBpBT6DyHnOX0EowL47oj9uu4OM/g4lc43oEsyoFe5nqbleeWwiJvgmi7zsWyHLJlcHT9G+OZXLSLcEYQYEnbT4EyKH+QboMPHWyuzHsDBxecwCVTG926fHJsPA4Eb0YZ8I03y+8dzWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dca451f922so4191604a12.2;
        Tue, 04 Feb 2025 03:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738668937; x=1739273737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQ77TkRX8woOw0II1Uyf/2qIvjpBF3NsVF6MNMkwyak=;
        b=nWsf1wnV45CasKG3x5VxYkn/RDm8sO97iOPqKnL7LsvgxzMC2xsfPtH9EoPJzBE58F
         AnYITAI8RcJgAt0zER9/+q9YjZEHrAUQbUoNZinqbRuza7HfnXpmenAJOzOR/nD1SE4Z
         PHYhkwqrOxPegi/9PdNUT026n7+eSQbKP1tXHgcilug16bDKwGNGR9wUXK1qoX1BZ/RT
         tlWYsGqXgpXqmsAEMj8dif3AX85d39cUYAlrKZtI1wv9GVMuT4nmyVwhJdMlvVN2mF0h
         UMOKs2dqiOjMJFxH5cbteZVRZva2tBhRXi/Mr4uA3EElu9Xg+i55sdo6YbOp8uJGGJSR
         0vRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7KgidffqG/QBjR/lzT/WlOnxqQ+xfnxRNckO8HE1d7y53SgThXQCwxGSR8TmE2TrW5X4hKhr6J6E=@vger.kernel.org, AJvYcCWiW8J4UnNV39TeyePZcIDFs+RbTbzjZ6R5rkMkzdOsurtv7vx2TVwrWhvZbSlB1bnK3ggkYbGa/UyXfF0P@vger.kernel.org, AJvYcCWlMS5rZkMXW5jzla+2pfFld+ZxU3aLIb55DkaTE8sKcVErwvSnXeH379KQeeClGZHsD41wd8zdP9k5n1enk8pa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2RiBuuGLkfsbD2yIVWmbyOicgC+j5TLJ+SCSd+os1rp1AbO9A
	9BnH3RS71b/4HgzDvBH04ZNLRSkrheuv578Ojo69QwZW2V2vhijnVU0Ynw==
X-Gm-Gg: ASbGncvw88F8tEQV3WIXcmEImjoHZ0sqCOtyyvjh7wo3PD/SeaQgvLC/6Bqq1C8830W
	RQuEyuEdZeOAyoIWaXYtviJKnaD/3rMGnx26OkmvxVVdjnCst3kskbx3qXLSCAHfQugnGHDI4fC
	SheOIfPPNKlZvcAK9Q34/IAx1ue9pJuxbVtTSrlDDo+rb9i7HHLx9Bmzib9cblYUTzxpQObcREz
	QidafrdrKslc5gDdPs0dsNWV+Hq+3073aMi1Dgwk3M0VmGVd+bnfg6cUatQ/QcbXJOGBXX6Gjzy
	IXE=
X-Google-Smtp-Source: AGHT+IHm87cbgXD+rLCRowe7VBMk5wnHEbY9pNjoPbxgIbQThnsfZYfWteZC7REzGIu0iTbvGZ9CWA==
X-Received: by 2002:a17:906:f595:b0:ab7:479f:8aa7 with SMTP id a640c23a62f3a-ab7479f8f86mr381597466b.30.1738668936438;
        Tue, 04 Feb 2025 03:35:36 -0800 (PST)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47f205bsm903107966b.86.2025.02.04.03.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 03:35:35 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 04 Feb 2025 03:35:13 -0800
Subject: [PATCH net-next v4 5/8] netconsole: Include sysdata in extradata
 entry count
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-netcon_cpu-v4-5-9480266ef556@debian.org>
References: <20250204-netcon_cpu-v4-0-9480266ef556@debian.org>
In-Reply-To: <20250204-netcon_cpu-v4-0-9480266ef556@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 rdunlap@infradead.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363; i=leitao@debian.org;
 h=from:subject:message-id; bh=TDqC7fD+fxMAo8/7y/hGgVVgkOS2xRk3o0bFxnvFUdw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnoft+jQ+jckGc0NrGzmgUOIngHg/gKkOAY9a8B
 CaEXDL7wWGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6H7fgAKCRA1o5Of/Hh3
 beNxD/9k5uK/2KGYwT4QKnLZSxAunyqfOnp+DE02IE6nvFj+J4SdCHvLbTJOTfm4wuVtIno0Xov
 SHVnw9iU9Nrm0D35+jcQKSIFMK4wYXtP5w5JAnZPSWpLtam7uNZcysNNw43+NxqwZV8bULnGIAh
 uIT8MnSmOqIQCxSt2qk4xEWazC6bQDC+jRVxTYnoAnfRpVkAXlJVDgULk4g5821AHm+qWndchoe
 Ndp/jD07f1jiyJEtRvaDWuNaE5XhB3f8UHtB+O5f3eyjeam4N8vvx6tMDqW6fc9rsJC5/h+g9qK
 cybPLZsGE9UCprnXDHCErn56Ww50mGuzMiMuluLk40Foqs2GkHUSmlvrHoMyGdVDaCQQwByyj/H
 G1Re2cWp7C13JE893EqZQZsGskSF4oHM3RXPCE5DC8JIxQGFIOIIvExzQPzzkbAOAC7en0EFpKo
 zYieT8gQBVIv6PI60pc7nJAa6QfHcqf3CepcZG7Ik/2FxPWltwPu2j/peeW5tF5O0mpvLpwFuKJ
 J2gMxfD/NeUIhM6U/ywI3hcGmxt3A8o1ahr3U6t1HyPpdYSSGO6FHGaAXsb/vWMeLOwCz0Py+yj
 1rNyY1TXw3wXsaqzHcLhtPTS4c3LpXc3VDIn6F4DB8fpEHVPUA134YT9vZ48jTiuzWFwn4erCe1
 JFcxflqOHbA1h6w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify count_extradata_entries() to include sysdata fields when
calculating the total number of extradata entries. This change ensures
that the sysdata feature, specifically the CPU number field, is
correctly counted against the MAX_EXTRADATA_ITEMS limit.

The modification adds a simple check for the CPU_NR flag in the
sysdata_fields, incrementing the entry count accordingly.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index c3f31b15ab8108f6be80d747ffc64a1eeb59a5a9..4255f547bdecfbdaf02ccfb28360ba6fc8b58bed 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -694,7 +694,15 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
  */
 static size_t count_extradata_entries(struct netconsole_target *nt)
 {
-	return list_count_nodes(&nt->userdata_group.cg_children);
+	size_t entries;
+
+	/* Userdata entries */
+	entries = list_count_nodes(&nt->userdata_group.cg_children);
+	/* Plus sysdata entries */
+	if (nt->sysdata_fields & CPU_NR)
+		entries += 1;
+
+	return entries;
 }
 
 static ssize_t remote_mac_store(struct config_item *item, const char *buf,

-- 
2.43.5


