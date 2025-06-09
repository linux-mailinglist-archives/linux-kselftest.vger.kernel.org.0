Return-Path: <linux-kselftest+bounces-34457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2B7AD1AEA
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 11:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1FB16B78C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 09:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5C925228E;
	Mon,  9 Jun 2025 09:46:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5CB1A238C;
	Mon,  9 Jun 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749462401; cv=none; b=aD5t2gQLxmxsZWdZn8lPnjeRJvWnnTGBxxU+Fk+yskPdepXHCh7G3Ct7fHocU+iRTScCl5HYx0GxiYS+d+BpxiIeiQE/eoIR7HE3bx1eDL1hxXXIWlY7S0TuZnk2OD7CF7ZFVmyYsoAOeFtpgi6h6MdskXBr9Ll1E32xUP6PC+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749462401; c=relaxed/simple;
	bh=PcMgP/Xx+i1wlGQQTmnJJGspz6T6srm8czqC/8uKNrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=unkOetBz+vRIDK6/mMZL+8StXGYLFX9dSpwH0GDoOC4fhu3ioHlGK9OviPUtirDr10HFRs2CZU5VrNaG8axKPpU9+NvPtd1uSkmoS29bh7serPDwNmZVxUk6DVZ21moaxkPqdgxZO9oRfBZPguv7eN2/iq9S6by/UhLxMMf6arc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so6607056a12.2;
        Mon, 09 Jun 2025 02:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749462397; x=1750067197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9srcSMol0c+UDsrqSjvhXDEchnbl8eBTxxIuTk0MKl4=;
        b=t/nYqclP+oqmP0wPFrj0J3mPyBP31jtJDDhky2xttFkrZC1/Hh66wMxN/v/dnElwY4
         TKL0bGOXH+YuPOBErWd2+kGlisDKxPbDncvXslqZNF6CZPT6TCzkhqo2MX00F6gHQTz5
         lxAe15uHhKcGY5f71q/cuwF/Qiw7R6Lldg4per1v5rE66Yy+wJnoE7k5IgIRMeFg/qhC
         KZSqH0D6h+TPGrPYMVK6yn7YiUrEwh38ATx+jU/RIpmAWkSwuD6lm3eyN6tvrkrisKH8
         StPMW22fijq2pfJYBd3j45WBPg9oEH2PTAUbiMAfSjtSzq7Pn+Kjdx5jHXZnUnA1HeeX
         nY+w==
X-Forwarded-Encrypted: i=1; AJvYcCU+SGPX5wxB8uWTgOxgjsL8gEILr6t624xxx7lFk+6ax9i0yRXJHbyfcgK+187h8mhaJuX7LyBeqnZKfbm1i0Rl@vger.kernel.org, AJvYcCXaN4Hs22b1jcWNS5CT/eB5QY1RyA8TDdT7r9pevVdHjQJ2BmayyiVo/BoV2palPHu+EIz4lNPTohWlKpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXC+TW/phRnchcUdX8cIFUaHaNpv1p8eUTBxhEUx3xd/WdtPXh
	iVPOaowFHr5FvmHZWbmBGmPzvYGs1VAMUKpothO6Qc9Q1usjkAF7S9UUNpjRiw==
X-Gm-Gg: ASbGncsoun/wz+hq0pKGmDZH15bbGRsQOZrjdENooUyith9V1cb/kJf73O39b2tAoEy
	dW57ysBBH2tPYKk0GZ7uWZw8sLovJ4cWcZelL8HXQZ+LZLDrl15L/9eIz5ZnFyh7gMdLtphLzyS
	ZTsMTAYoMsVhMwF9XoFm8XJZ8waIGQ6NN35S+RgyKbfEccwvcwYcEkKaL71jDzyZ0jyuSVC9Yr/
	jISAEf5Xe0TrWCwtbGyFX9abUoeqBE/h2DI4TpZQsIM7Oc07CSi+2Fdknm9TZG0EGIrnZa8jiRS
	l3KTijIrlPRO1s1noggLNWpjkafEC7yrd3VjnTD2mdX+hFNPDeArNg==
X-Google-Smtp-Source: AGHT+IExjHyiPhte1wwY1E+snj45M23nryaOO7uTbbMCxtigSnjey2IkVn1y4SiCS8mVaf9DAC0EDw==
X-Received: by 2002:a17:906:dc8b:b0:ad2:28be:9a16 with SMTP id a640c23a62f3a-ade1abc4055mr1125553066b.51.1749462397154;
        Mon, 09 Jun 2025 02:46:37 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db575f9sm523118766b.48.2025.06.09.02.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 02:46:36 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Jun 2025 02:46:27 -0700
Subject: [PATCH net-next v3 2/4] netconsole: Add automatic console
 unregistration on target removal
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-netcons_ext-v3-2-5336fa670326@debian.org>
References: <20250609-netcons_ext-v3-0-5336fa670326@debian.org>
In-Reply-To: <20250609-netcons_ext-v3-0-5336fa670326@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, Usama Arif <usamaarif642@gmail.com>, 
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3187; i=leitao@debian.org;
 h=from:subject:message-id; bh=PcMgP/Xx+i1wlGQQTmnJJGspz6T6srm8czqC/8uKNrg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoRq14syo3K59GlRRtZ/UTJ18TAka+WDv7liY1z
 Ie8t+/sMs6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEateAAKCRA1o5Of/Hh3
 bfmrEACC6/RhIchyphNzgUoDnwYukGg0+m1yS0ka+SpqBs/N2ddHwFjNVNHKoiKLt8Quha0EF/Y
 oDAklIbHOP8eR4ZFBHK6D5AhGw3M5xeAzZpNMmI5KRs0+4UUqUIhXa78tftmEpK/ZxhxTdnfm07
 kOHZSYM9iJud7vQMe3ABkrbVVKzWqfmLZAwZhyQJTJr1HL5PuFHXYNokJKOJEEFRy3PDir9aYKx
 +o6UHkXx0aHXhar4wJXqya1N6EUSQh8EVsfvFpkvk/oBYMgc5WAfDb6bAcTPDJ5N472VBpOF3S+
 IT/lUvDpOf6uWtTGgngw3Cqx3yfSOPH5sy/FsK/ndjLMDKezfpdUAeVD4hRERuCI1OAVZXkm53j
 et54Gea4bNTatQDGdsGUJpKB7Mk9Ej7fb+dFrNRg5m21e1eKV+czFr/e+bLol6VckULXctpVP0i
 yr3MmoH/jqnSqYPpkWo4aFe4beZSkifRnfUiu85xe4/qfQKhRsVBsIRDUiR1Qack+2ytzhz3RHN
 kk2OI9uVsjRemCllal35e9Mk+6x6yAtBkpnUEQ93RN37AeEiKqr9B5AcOijKHFA2lZ9GhZVZztN
 HI1ZgqkiWNAF3rxuHvMk/9Hj1tvH+Xj0typTIMy1JcEOXIXHC0Ze3YF9oVgWELKPn1wPLtuyaSg
 XeTerqsc4OR1znA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add unregister_netcons_consoles() function to automatically unregister
console handlers when no targets of the corresponding type remain active.

The function iterates through the target list to determine which console
types (basic vs extended) are still needed, and unregisters any console
handlers that are no longer required. This prevents having registered
console handlers without corresponding active targets.

The function is called when a target is disabled and moved to the cleanup
list, ensuring proper cleanup of unused console registrations.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 01baa45221b4b..21077aff061c5 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -460,6 +460,33 @@ static ssize_t sysdata_release_enabled_show(struct config_item *item,
 	return sysfs_emit(buf, "%d\n", release_enabled);
 }
 
+/* Iterate in the list of target, and make sure we don't have any console
+ * register without targets of the same type
+ */
+static void unregister_netcons_consoles(void)
+{
+	struct netconsole_target *nt;
+	u32 console_type_needed = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&target_list_lock, flags);
+	list_for_each_entry(nt, &target_list, list) {
+		if (nt->extended)
+			console_type_needed |= CONS_EXTENDED;
+		else
+			console_type_needed |= CONS_BASIC;
+	}
+	spin_unlock_irqrestore(&target_list_lock, flags);
+
+	if (!(console_type_needed & CONS_EXTENDED) &&
+	    console_is_registered(&netconsole_ext))
+		unregister_console(&netconsole_ext);
+
+	if (!(console_type_needed & CONS_BASIC) &&
+	    console_is_registered(&netconsole))
+		unregister_console(&netconsole);
+}
+
 /*
  * This one is special -- targets created through the configfs interface
  * are not enabled (and the corresponding netpoll activated) by default.
@@ -493,14 +520,18 @@ static ssize_t enabled_store(struct config_item *item,
 			goto out_unlock;
 		}
 
-		if (nt->extended && !console_is_registered(&netconsole_ext))
+		if (nt->extended && !console_is_registered(&netconsole_ext)) {
+			netconsole_ext.flags |= CON_ENABLED;
 			register_console(&netconsole_ext);
+		}
 
 		/* User might be enabling the basic format target for the very
 		 * first time, make sure the console is registered.
 		 */
-		if (!nt->extended && !console_is_registered(&netconsole))
+		if (!nt->extended && !console_is_registered(&netconsole)) {
+			netconsole.flags |= CON_ENABLED;
 			register_console(&netconsole);
+		}
 
 		/*
 		 * Skip netpoll_parse_options() -- all the attributes are
@@ -528,6 +559,10 @@ static ssize_t enabled_store(struct config_item *item,
 		list_move(&nt->list, &target_cleanup_list);
 		spin_unlock_irqrestore(&target_list_lock, flags);
 		mutex_unlock(&target_cleanup_list_lock);
+		/* Unregister consoles, whose the last target of that type got
+		 * disabled.
+		 */
+		unregister_netcons_consoles();
 	}
 
 	ret = strnlen(buf, count);

-- 
2.47.1


