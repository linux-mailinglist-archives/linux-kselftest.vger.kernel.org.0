Return-Path: <linux-kselftest+bounces-27167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B546EA3F679
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 14:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88565189587A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E02101A0;
	Fri, 21 Feb 2025 13:52:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA1220F092;
	Fri, 21 Feb 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145943; cv=none; b=P+9imntsrcZxx0H/d5Qkmf8tX8QvD/AzU3T4D35ogRXEhjkfwVSimCG9Xza2N6cYbWktPlX7dBa4tO0AC/s84swM94+J06WFpEMzdcWl3TF8BpkuL/ZHPTHjklC2dONnr8g1+Wq8AKKL7wGzhJ3A2jLmNq8Kn7bp3TTTsFyFdqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145943; c=relaxed/simple;
	bh=u5ltNMXLomd/VKoMx0k0X7Td/0jnNXUeCNEZOwKvmD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EmWVehJp7+UnkJu5FvUpvEdreNzaRrTLgmnVXbrDNltHWob7HRA9LhZUK1/cm/bGRLQd5fwgAOyk6VoVBmDN4gD6oMOdFRq7xSOcP/0/AauhduzuRk/QT8z9Kds4eFk9Fdza30YlHgWjbTdtoJasFTrnqM06t5WpOcUC0BySgrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so5935284a12.1;
        Fri, 21 Feb 2025 05:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740145940; x=1740750740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4/MpsTJO29ajEchL8wNN+rTvfyOSL6kg7YIOeeMVYo=;
        b=GLCWz6bYo4YPi4JskdOAY44sZrHZy258b7sOF4ndCDbE40GugZQsmLR3sNlqaSB7gV
         EBkS44mNy+GdZD3HQD6FiR7/0xF9oscQw7ePMUTySdU/LwHT/4rIG81lwZiRP786H6w0
         ityrDK/0X2ECna8qX+CcaP9vvDrhYGchI2UX9AZyttPlGdvV5Ue+zetdsASSp+rsj640
         m/a1rBTq92hYkjobXktvFtyNxEUFTlA0x3bQic3j7wNZi13Cd7lxggubf5i3lmNQ1UIK
         OD/c813F8BJU63WBgKzNaKBHqJR7yMQDnw6fa6gLqGnFZxKD4umQ3Q14Ffua2meTuUXT
         Q4Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVqBgpunv4iZlsiZuN3z48oc6nLJTbzxj4QTLi2rcBiXAAJjDLAyZBJSNM+ycS/B59Yx6dcoV9FxhY=@vger.kernel.org, AJvYcCW5wI8GEll5a6cHxMADLbnqXnMqNIVz28iAYzn7zfsjefTb9U7INJ6j216CjZpUZvPM2hL8YIEtbuKaz20xPzZZ@vger.kernel.org, AJvYcCXtBvstjtOqxrfFTQJ322CPfL/1oUGKZKObBA6ddf3N4C4iQ2X3MHwQA7RPMb1tsg+vp0n+FxY6wKuUqJTT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9dIoHjoZ/RK355d3GvI7UVujiLJP+6lFzWaLsD5HcfHqWR8JM
	wX85AObE4GLZ3AKOvz0y0P/aBvfpSE9CcnzguwIi+imP+SQ5GFLlZXf9yg==
X-Gm-Gg: ASbGncsM6wGVtcmnjtX8QgS9+xJWKW3IkSatfVTkw9TMm5GAqxIV4M8KtG8GsDUF2uO
	ShIQ67NHWKCEl1kvVsirskTQ0ZG4JL42egSoSjkwRV6dA50NIJq+RfKW5d9Hgx9uxVWt30JcGz0
	Dtjq2tmkFrzMgKStl1VgYJNla7ZJcQQFpySr/gvf43AZhy1wAZXYwFckMJ3RDqw93+YV0P7hFZT
	PRT7/DY2sPiu9KH4UNAGi2DKTuS+imucfusHZcFWj42AlOuagADVMljMLwRNdy9BbRgtvl9oA8O
	7KbT2u9YmPQOibvl
X-Google-Smtp-Source: AGHT+IGidcbdqjOzKFbsbBTB7aHNtjKSCxzH9uMEGKbJStgH8B9nmnwmj6QrA/l+Ba5YhDC31pZsdw==
X-Received: by 2002:a17:907:d109:b0:ab3:3b92:8ca5 with SMTP id a640c23a62f3a-abbeddc5984mr741431066b.12.1740145939892;
        Fri, 21 Feb 2025 05:52:19 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdac1015dsm496385066b.127.2025.02.21.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:52:19 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Feb 2025 05:52:08 -0800
Subject: [PATCH net-next 3/7] netconsole: add taskname to extradata entry
 count
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-netcons_current-v1-3-21c86ae8fc0d@debian.org>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
In-Reply-To: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=leitao@debian.org;
 h=from:subject:message-id; bh=u5ltNMXLomd/VKoMx0k0X7Td/0jnNXUeCNEZOwKvmD8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnuIUMae+lYoGodNvYOK9LVnzJ8VBKd/7S8vY/i
 iyyJmLAXBOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7iFDAAKCRA1o5Of/Hh3
 bYyXEACH5A1C0xX3mV/h0UVgeJoWPBdPDdPY79hfEvBBrxjw0xhrs6Fw6dHmuRHzywnIkoE6XqS
 w7+Z8AbsZwIA5eLjaT703dOlB6V1hfvfV/GdB8VhETqO6HTDUVhYGiPE0CBrWwFzLoszwrvCVME
 ULj4KdNp4o6HwD9Yr4UOKkTm1GlE+veBm4qjaAbosoCdNg1ZTs0rt/W7f1kz8Drt1zD+cF0HjZq
 SlB2rgEKtZ6VdQd1HgeolSHbiXTg1LXKbl99Tebq5WGh73PlHmoKHWnfSrRNDevJNJbyRLyoCLu
 Ix2aTp8Fo1eAhd/oGR7PEnbQEZF/tmRIcfX/JYI7Hvaul+iVDb8nphmgL5qO2Mxd7tlfBRf3VhT
 AQxsxe15HGRpKplXhIZ71boWxW0p4FOYwG+lw77rhq+7r/4rLc/eb/jFD3IXCpMIrgsYHuci/hn
 4KiYJ78ID11irsDD/SZK7qaH2EUw6NHIRn0SxCMTcsVzT6o0SCoKVlxAUpurQFH5/K1lkkwFXro
 pVOvDOMP5iicM8CQiNMuIZ8XqXTv+NDFq+30DjothkHM8vPQkSgN3LgqVlxZ4TJgVUWzIifv02M
 hMFKkbMFmWtzGxOOj9SFY0loIJTiOyBWSJ9aW/b2YtheCq8NQMOJWVlW1Y1P39+nHkko15aL83x
 yf/mPGaKYH73tWw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

New SYSDATA_TASKNAME feature flag to track when taskname append is enabled.

Additional check in count_extradata_entries() to include taskname in
total, counting it as an entry in extradata. This function is used to
check if we are not overflowing the number of extradata items.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 26ff2ed4de16bce58e9eeaf8b5b362dfaafaca0a..1b109f46512ffb7628c6b34c6efdfc301376dd53 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -104,6 +104,8 @@ struct netconsole_target_stats  {
 enum sysdata_feature {
 	/* Populate the CPU that sends the message */
 	SYSDATA_CPU_NR = BIT(0),
+	/* Populate the task name (as in current->comm) in sysdata */
+	SYSDATA_TASKNAME = BIT(1),
 };
 
 /**
@@ -701,6 +703,8 @@ static size_t count_extradata_entries(struct netconsole_target *nt)
 	/* Plus sysdata entries */
 	if (nt->sysdata_fields & SYSDATA_CPU_NR)
 		entries += 1;
+	if (nt->sysdata_fields & SYSDATA_TASKNAME)
+		entries += 1;
 
 	return entries;
 }

-- 
2.43.5


