Return-Path: <linux-kselftest+bounces-35118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95F9ADB797
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 19:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E9F17218A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A171288CB6;
	Mon, 16 Jun 2025 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7/QiXmS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D1288CA8;
	Mon, 16 Jun 2025 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750093806; cv=none; b=aLVZNnI+bzSOMBrI9qpVQWb5PdloU/xWw4CmCT0X8z/VY4zHXk55vkBw7vdHKNxjL9BqB8W1NrZxWRhISqhGZBHUzKwhm81StH7j6+J2BHlLIBbQJOn2COeYZkYg+YOYhIMXqUd+oZ0NP2qVD4JANR04lo/8PLoKDTa8VT1rYu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750093806; c=relaxed/simple;
	bh=mfkoUBQgABU7lMjOTs7x+P4cuvWas3SbIkz2Wq0vfk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+/31IXwPg+okc2R2QGMc0/lotWODTpUPe5sKs2eYkMba/EhDiupE7lxivZdfTV+TsnaQjDBpBklTpQQv/5G8ZeLh01NT0cwnSn4rVqzAujMK5SuAhWGVy5kpbvlPc1tTFnlLWTsPc33DKoI98yc3g1hN3BfZgE8yBB3aKN1VT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7/QiXmS; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d09b0a504fso41166385a.0;
        Mon, 16 Jun 2025 10:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750093803; x=1750698603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YfkFvrTGiA83jTYNLbHNHZ9OUEi+RY62zinuEM1ItI=;
        b=S7/QiXmSuwDLmgT8oSoQPveuWqnbCZcgHiOtFGBDlWLttgrKDp3IDMdsx9bKvaqVL+
         dIUt5WBTLk5sM0dRpIOKgvQksyqoblj/rRNgNEVgX5VEScbBMzXosEu6ocN5HXGdrR3B
         91e59bRce0lKHeODaqSPhkf2soZQurlRRofVgJfPtbCegxQGGp5vcxiE3CEs/BiRKR+P
         8KodQHOIhvctPHsglrP038qB3ogGnwyozz9jQXLxfL5oBpvsPoKTlfpxcXTW07cvRvlI
         NcgGThW+YbG7vJfmwpMB9594mKz3rh66YvailSmc3p7NkRrdps6FrwgdkMMuB6/SZ6r5
         ZKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750093803; x=1750698603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YfkFvrTGiA83jTYNLbHNHZ9OUEi+RY62zinuEM1ItI=;
        b=QgTcEhlngpftAEfRKiED8NrMYVrJ5ro372bOcjnZ4hAjOAIhhlHcPUSM73OPTi3QVh
         GhOyHmZcfodaVs5+5YKoowp40q0SfoHAXT37klzYgnwuN4Bo6MfH49Jsjr0+L6GNvqi+
         gpVQaAkLxPa577DTSNIiM0smQIL6Or4/Iu3pPAqo8dU0xo7X3qcCrEoME1jJnCYoUT6j
         X+ehnoaNppvgZ+m+HyZzvHCM8/iUch1LrG3PPNHlKYICYKDI8rcir2fnP2unIMtZ49fJ
         KG8u219mw5XIqxo+7M/nMoU0InycknbPzE39nbhpI+wAd+fNeDtbbanP+7Kwi1UaDJ6E
         D6zw==
X-Forwarded-Encrypted: i=1; AJvYcCU2PXPvBfRbi08M66Nydbk2gPEyrRWBctTcUdBL2Kk0Zg+DyP5Bt1QEl7AWRsX/9OTwwmTprgOkd9WZSi2DlEG1@vger.kernel.org, AJvYcCUbqzwnCoV3Eg5YB3NJZ1LGV46nVNhJtWQEwiTSZD66DmP4+4+KlDiHIHWqq8BzRcFdXbiLTENpcUM=@vger.kernel.org, AJvYcCUtFwFPv5kGF7cc1TOu3XzT6TeEiVT8gA78U776AeS3GKqHzGMO1R1/7uZfGpvPPnZO+ocQtxaXhUHeBeFM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjoe9WsBGN2HkfPgUF8z0BqD/CpQUXDTdtv3cXS3I+wxmuw5uv
	NH0J61t3qNpgaIpixYf30I5wGy0Am4n+KMw4z2fREaWqj1oioCWIsCLq
X-Gm-Gg: ASbGncshMbAVmYAj2/eE6exE/NSN01q9igOamAiw1r0+RYZKC4OUMKJRyJVy5GWH3oB
	ykiGvcGSajBZAmBgNXvgyTRDrE/S+qrlsJSzpavepoZgKyBOyUTri2OCj9imJDMDOBbjwDE+uwi
	+LZhX1bcUYysOzAy9mA521+ZdzDKQo81C65xuVrtWEo8mKeE6bw7Wk1dnb4Xp5I8xVaS+izeBvy
	R0kmqqhHdvKxokU/uElzCqv+DkEYh2sFkwPcohi/9orfaEgmWx6/swrwdkDMehvb0zcuPkU18uu
	9UPUvCrn6Y9fFpTop6GKXWP/IUqc4EQ+sJ5CoRHERtpwjYjd0/4h4q4=
X-Google-Smtp-Source: AGHT+IFZLM2dpQfzIgUi24yS3+pKRzXJUGlugx2yV1qrq+GQVz0YIguUKZubmvsiXXvPUSa3RXb0ZQ==
X-Received: by 2002:a05:620a:191a:b0:7d3:c688:a587 with SMTP id af79cd13be357-7d3c6c19342mr525863185a.4.1750093803376;
        Mon, 16 Jun 2025 10:10:03 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:5::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8dfebf8sm552238385a.29.2025.06.16.10.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:10:02 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 16 Jun 2025 10:08:36 -0700
Subject: [PATCH net-next v3 2/5] netconsole: implement configfs for
 msgid_enabled
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-netconsole-msgid-v3-2-4d2610577571@gmail.com>
References: <20250616-netconsole-msgid-v3-0-4d2610577571@gmail.com>
In-Reply-To: <20250616-netconsole-msgid-v3-0-4d2610577571@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Implement the _show and _store functions for the msgid_enabled configfs
attribute under userdata.
Set the sysdata_fields bit accordingly.

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 5f8c8c6c5393..3bf8777fcd01 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -489,6 +489,19 @@ static void unregister_netcons_consoles(void)
 		unregister_console(&netconsole);
 }
 
+static ssize_t sysdata_msgid_enabled_show(struct config_item *item,
+					  char *buf)
+{
+	struct netconsole_target *nt = to_target(item->ci_parent);
+	bool msgid_enabled;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	msgid_enabled = !!(nt->sysdata_fields & SYSDATA_MSGID);
+	mutex_unlock(&dynamic_netconsole_mutex);
+
+	return sysfs_emit(buf, "%d\n", msgid_enabled);
+}
+
 /*
  * This one is special -- targets created through the configfs interface
  * are not enabled (and the corresponding netpoll activated) by default.
@@ -922,6 +935,40 @@ static void disable_sysdata_feature(struct netconsole_target *nt,
 	nt->extradata_complete[nt->userdata_length] = 0;
 }
 
+static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
+					   const char *buf, size_t count)
+{
+	struct netconsole_target *nt = to_target(item->ci_parent);
+	bool msgid_enabled, curr;
+	ssize_t ret;
+
+	ret = kstrtobool(buf, &msgid_enabled);
+	if (ret)
+		return ret;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	curr = !!(nt->sysdata_fields & SYSDATA_MSGID);
+	if (msgid_enabled == curr)
+		goto unlock_ok;
+
+	if (msgid_enabled &&
+	    count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS) {
+		ret = -ENOSPC;
+		goto unlock;
+	}
+
+	if (msgid_enabled)
+		nt->sysdata_fields |= SYSDATA_MSGID;
+	else
+		disable_sysdata_feature(nt, SYSDATA_MSGID);
+
+unlock_ok:
+	ret = strnlen(buf, count);
+unlock:
+	mutex_unlock(&dynamic_netconsole_mutex);
+	return ret;
+}
+
 static ssize_t sysdata_release_enabled_store(struct config_item *item,
 					     const char *buf, size_t count)
 {
@@ -1037,6 +1084,7 @@ CONFIGFS_ATTR(userdatum_, value);
 CONFIGFS_ATTR(sysdata_, cpu_nr_enabled);
 CONFIGFS_ATTR(sysdata_, taskname_enabled);
 CONFIGFS_ATTR(sysdata_, release_enabled);
+CONFIGFS_ATTR(sysdata_, msgid_enabled);
 
 static struct configfs_attribute *userdatum_attrs[] = {
 	&userdatum_attr_value,
@@ -1099,6 +1147,7 @@ static struct configfs_attribute *userdata_attrs[] = {
 	&sysdata_attr_cpu_nr_enabled,
 	&sysdata_attr_taskname_enabled,
 	&sysdata_attr_release_enabled,
+	&sysdata_attr_msgid_enabled,
 	NULL,
 };
 

-- 
2.47.1


