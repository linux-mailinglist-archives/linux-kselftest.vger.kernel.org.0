Return-Path: <linux-kselftest+bounces-25907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274CAA2A6DD
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 12:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8E71889AC1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 11:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294A922F17D;
	Thu,  6 Feb 2025 11:06:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459AC22E3EC;
	Thu,  6 Feb 2025 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839977; cv=none; b=Th3jzp6gOLXyk94blQcXil2YFp1iMnGH+82cdT9qxWk3p1uucw8q0As1SuXh3wYdyHMDscRd+lt0AffrMkM5HvWO7ZkYF0w+ZkDhY1VphhPu10qcq0Vj57xVySo07g8eGzzqcmch3cKAOOBd6Bgq9S4xe9c0h7GrJ+MmBvdZ51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839977; c=relaxed/simple;
	bh=146+Fd7GMEHjIB2x3rHlp8/1LduCZ88lYbm9gyDIpfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JxvVMOeq6+IALUnMtISrkls1onsPw4oiZG/9d3IZCsApTyh35UrHuGHsw/ceSEuAGnQpZQRpKXSXXIT2uE8X2qARlu7VKS2bO2fbBoXUNMv7UnMlsLKgPaFXbCoSBZ1K1+81iH2pKygKfFLgo8IcOCFLfD0jTpLMVvob0mJ8Ds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dcedee4f7bso1188600a12.0;
        Thu, 06 Feb 2025 03:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839973; x=1739444773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v60yw++ddCI3iUtxUgKCBy+AvjYXItQZQ0qYmmzPQnw=;
        b=P4i8CDxsbtUCnaF+yiPtG3hBdpsOcjaxkpvRrTzd42I00jNkpmo4Hi4Mx9Yo27IgY0
         u2YfOfJvdvOBAkOPwZGZA8Zoj5YvUYapABBLdkHrRXAhoWrGTuqmf2753X9Src1oJMSj
         fYWFjTq5iSfVvnbzyg1KVP0MsDser62MaW5kxH0Jlh4qNN80GMZSzkHKO/VcsGMwzk9S
         0ocDjWdMBJ2PoV9BPMLBm1/No467s9Ci18XrizZmx5fixPwGtJCaWUw4UbbOO02i5oDt
         toZQVXQmLubCF+kbQRSMjNIvxHVKs0c3G5tVLsIhbeGurC4wFXCDCnyH8fpCE1DHRkdu
         EB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWSIwiLYpvHQoe2iq3s7KdSe2q4eoC6R09rqt+AuDN0C0iZoF4FG9X975/gUAQnWdFBZ9QL6JHvzk=@vger.kernel.org, AJvYcCVgeIbarB4ETZZX4YwOcSE5S2LDxA88Uy4ErObOtwLwyAhLujlwPuEJA1/D2tIzTkHxWenxJmhU4wYyeyIYg81g@vger.kernel.org, AJvYcCWABgtDlFmvPgdAoXYDht7JOdR2EY5J909qXJTkqCxvcNdVhfYPHYNeDIBl4tvy2cTSeykN3bjxuao1i+MM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8p2vK0SZ8tRbQ2ncD4Lp3Dw5scXOWKcl8wbhEHZNAkhF7OF5c
	FLYPD76eLrpaXXzjQSbQwaWKUvv8TkjuEpnnG0XbAD2+P3IPKpkk
X-Gm-Gg: ASbGnctJxaLTb3h20ZqXLdj90etI/rI2gdHs7wLR9CFsSWuT2Lqymw7flLVmSjIOc97
	40rNvO4qBVao+ES8mM9hGOtIXmx3RzxyWXQE3DUIFE8thOdMoAjr8Pu/ugDSazkoXoNvxx24Ugr
	eAtDC/kO0UD9fDVpNbxOvlRSJk9ZQc3Ub3Fjic8AMx/7C0R5mmbeNI7cRysozwvJsZLOenxFSTF
	9lu/w42fUjQfimwFSRwxCVnVvg4+OELSYkEobn+wY4X9sEe3XA3Xy2iigGSjIlxIjUCgPOmcu8+
	OQyfTg==
X-Google-Smtp-Source: AGHT+IG+p+1DmFFdJVRkJTROJXqXPU7O8SQKva/DWcOTuD4kF/FInXV/1u4PhkS+FyAj2Vl47BaWEw==
X-Received: by 2002:a05:6402:388c:b0:5d9:8877:895a with SMTP id 4fb4d7f45d1cf-5dcdb732cd0mr7584773a12.17.1738839973305;
        Thu, 06 Feb 2025 03:06:13 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b990b6sm696427a12.48.2025.02.06.03.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 03:06:12 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Feb 2025 03:05:56 -0800
Subject: [PATCH net-next v5 5/8] netconsole: Include sysdata in extradata
 entry count
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-netcon_cpu-v5-5-859b23cc3826@debian.org>
References: <20250206-netcon_cpu-v5-0-859b23cc3826@debian.org>
In-Reply-To: <20250206-netcon_cpu-v5-0-859b23cc3826@debian.org>
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
 h=from:subject:message-id; bh=146+Fd7GMEHjIB2x3rHlp8/1LduCZ88lYbm9gyDIpfE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnpJeanF6eo7+Yu1shhA89YfURblQQdN0terIOc
 aWg6lvKukCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6SXmgAKCRA1o5Of/Hh3
 bY/SD/0TrSjAMOxvmMn+XwfcZfbi59Hy7YGIfYsbKgPZ1iuBAePpFATHQgBZKlTjxz8KnVfuXaS
 NtXZG4mK3XStf3Nm1m3wAjd4s8hti4X7WKm51zVr7UYmIPGjnV9eleaqkj0bmirQZPrpGaNSUck
 oUC38DVhDL0m6uAmGQQxcdAE+Lr5n5GQ9khjDh8/H2VXAjSJsa1FjNNK2E8wF+Ni6uNh2h8+blx
 DWthQJTqQvmOf8RfEf0Wetk9ZagcdYGRgV1eeJ0ZCsg2TyGbCMo60wk0ark4dsXpmfATHpHRZzw
 6jqtmVD7C4RsOMswXMXqO19ryfxokVksbZqsDWSMaWowzLR9tBH1652XEe7PV2LMZphzrJMdWEm
 Z8HGEQ8UHroaiAszJ00YeCLhFXPP+EP2Y0I2YBzBCfkWm24s60ucx2E5FZk3hD7VT6rC5vDOMrm
 RhAqw31LPIxS3lcDrl6C1YjD57aQ+eLkqSJnpSIV9WZEmbfUqRj2zGWusteoPhFv9u/Uq6d5gqn
 bo6oAmlYNEsmIsOsQ/V03Qgi/mCAk9e9ws1tUDb+x21MWGRVWXZuw/lqUR0YctOQfRLEc3759CR
 AupCNQMPUg0YNE3Pz+f8tYO5Sl5gd2xPMKpRfntR6c+l2F8afyve6eDK6NR52zO4AO5dGsffGZQ
 vr2Vq9XSO/VPE+w==
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
index 710330ae8ee462083dbb4aa889cb0ba0cb5a7475..50739c7dbfb6ad5b1a65ef33325cf4dd6ed02031 100644
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


