Return-Path: <linux-kselftest+bounces-25905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E976A2A6D6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 12:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25091889ADA
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 11:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E81B22DFB7;
	Thu,  6 Feb 2025 11:06:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305DC2288D7;
	Thu,  6 Feb 2025 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839973; cv=none; b=QED9ZsF6gtvTtl1Z8dPMGbyI3+z+HRLDwsE9krv9rC9E+uQNR/KVvddVLcdqDkfAN/nAoElM7xOuasFSdMd2lgS1/QJ0qniJ9yvpKAjV6sJCSabG59yvVhgWawfwBJXJCf/rDR+HUX1AlDsM5CL6wk1L0STTb7ZRHc8Wym/55w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839973; c=relaxed/simple;
	bh=+niiaHiskkhsTnTEZJ4wU+lHWH66HqehWyev2K0YeO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ag1VjMY4qeVJufAS5W4Gxv74JD4YQqHy2ZGkcUCsBEdPQxZD62q6PZfOT37H7jVTNSVniZ8M14Hunq+MWjd8Zt1yPMoJHb7HxSgktIXMrg5eiHtv3oU75NhB8hIaAtsdIc9tN+7yT+EfLZiIJoiEq5NmyyFqfmWOTzW/J7PnD1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dce4a5d8a0so1378037a12.1;
        Thu, 06 Feb 2025 03:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839970; x=1739444770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/paCx3x7C5/fSrkE+t0Z5vy0JRj846fYPbO5BYY5RM=;
        b=hvt70c849CD/J4D6i4+nVfKxtZlpMfW7AN4NzWo48kMLUAediXnzLXuWaTG0TGdPcE
         u3YrVm/6WvyMc2546W/7EDmW9s2yOdbqEl6erzkrCIFKGNBQI889DwP0wo3mcLHasYRp
         C5GbDga7pmUeix80elMCf9piUwI5NXa+V7njqt7RDhBv/axJspYaRa0T+IEPgKZcXvv3
         p3ED8aKvEWB6fSSQqUD4l3yg9u0uoMzWi5SDPKvecQk7JjO3CJE0kEjNdmMH2dCU01q6
         dIi/MGO/Q6CFWbrmiIZKgynuoAXJT+GLoPfHknMZsdX8a67rYA0X4hPvmpFzWIERi7zs
         zk2w==
X-Forwarded-Encrypted: i=1; AJvYcCUFnhC0jeRZsobGYJ0HA5nqrCzsCq/8NS90ZrfW2NUSOd+mKijzwrgZXRnjYwaUv99I+20lbcisVVgn9qiC@vger.kernel.org, AJvYcCXWteVEGH5Gkv7kr7USAVrGGYH0w3xTWTpr/Dne4ea9BTIv5ecupieBwXFZYLk6A5qFQ7bseJo930wpuA5HCCsn@vger.kernel.org, AJvYcCXqKIW1m9YfL9qz4/P8X5CN0isX3tYqzNL1WIJyIsk/xQnSi5+7+CKfDRG1y+M6CqxrBGk2sOtkM3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8je6c7citG6ZQmkB+Skje8RCgs7FhYeAjAbpGANMBwC9w7z4x
	9Xgqm2ZRcGPktkOre2bFSIaVzhVbzuS80vewk8u+ZU+WlwshcARq
X-Gm-Gg: ASbGncs/NcRap/oq3DNTSoADc16cQykfDva7m3NW2bMyXAmYcTj8oD3IO+4dSAAI71v
	NXNlhVvqy+LNU9MEdDx+PpUaXWQO64ESKt3TvMV1mse3Yppu6aCKQ19K5yYB4o5xoOiKtpvr0+c
	MrceEzR5mXGF1y4vqCYgEhZuUEY7iOkAEPe4WDjXGZvJwY5RDFevaITUJzzaPPmEEDdCNLh7ppO
	H4fMi/WD0QgKAk1lysbSaU2i96lv2NrgAtqqWOeDaF2PAXrwuUV+SwlQIgtWokrU2lY7LGbz7EV
	UKs=
X-Google-Smtp-Source: AGHT+IEB23Ju3E9DJMpJQ7MTISnaIRXQuB9GVRcsqItI9Ob6K6xPb6asE1TwgWbZmQ6kqdi3ciO6Uw==
X-Received: by 2002:a05:6402:2812:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5dcdb762d40mr14605385a12.23.1738839970108;
        Thu, 06 Feb 2025 03:06:10 -0800 (PST)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf6c9f93csm693345a12.51.2025.02.06.03.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 03:06:08 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Feb 2025 03:05:54 -0800
Subject: [PATCH net-next v5 3/8] netconsole: Helper to count number of used
 entries
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-netcon_cpu-v5-3-859b23cc3826@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2043; i=leitao@debian.org;
 h=from:subject:message-id; bh=+niiaHiskkhsTnTEZJ4wU+lHWH66HqehWyev2K0YeO8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnpJea/JQi1p4uc8Fv+crwWRCulPgJxkHpLTBfY
 tzjTiUmvQuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6SXmgAKCRA1o5Of/Hh3
 bcs0D/9MAY7WpEi2yV+6kRBfWRZCF17lxg9vANvh891T6tnI1IBvZUkWGxJv2UwYsz96TbkQdOG
 Axk/KUmJkuo/wuXQlY6OpMHhMWlURmcpdOlOInmvxD7WS2f/7pBOcrjc2r3UWZE04snAVouAld1
 mQpPBsceCnYjXvHsJuQFZFWu4FP4DtZEUD8fImt4Fgunwj9fOQu2HolzJ3AxTMB+pyCEdfgUX/w
 glWZYsnKaQ9xcbIFOWow/0ImdnkhirGh4NZ4v0BhRPlxtVX1Bs/rlmQRjKIkCXc0jJKWA2XWWq9
 miQ8EAnywFvyb6NKgAkZMI3GsUoLMrwG76c7BAasRFgy08mxP6QidfTIGaf56hOXCgy//gUtw3K
 bWluO7Iafv5sqQyxyIY+AcfGvSc1bplNNcZGXLMQsty9UZoRoAmxO2uJoZzdRIdpCyRvfn0aJqI
 67L1mJrzw2qkXCTDBeNmNW6f+qnCxPjj8FuCMBVbXxYdANActgtDkG9Ko5AwE56ziSYQCVzCGOs
 SGthkYCoI+dB7eGuGtDOG7auzu5oWUmDT8B68kL98q5n2mb4Lt6zcFaqvX8sBRVRI1Ee/TFJVtR
 mMy16/eUWGdmaNRi38TX23AN5PY5fS1ewKbiTY2ddoIWpd/SYEPwJPu9vGWhqOZ5z/M2lAS0bQj
 /wM6ykULEwJK3kw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a helper function nr_extradata_entries() to count the number of used
extradata entries in a netconsole target. This refactors the duplicate
code for counting entries into a single function, which will be reused
by upcoming CPU sysdata changes.

The helper uses list_count_nodes() to count the number of children in
the userdata group configfs hierarchy.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7f05c7f74c31ce26a7329c784bd99305b7bea0e8..15daaba65c8827bf399f0623cc42d310626cbf68 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -662,6 +662,16 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 	return ret;
 }
 
+/* Count number of entries we have in extradata.
+ * This is important because the extradata_complete only supports
+ * MAX_EXTRADATA_ITEMS entries. Before enabling any new {user,sys}data
+ * feature, number of entries needs to checked for available space.
+ */
+static size_t count_extradata_entries(struct netconsole_target *nt)
+{
+	return list_count_nodes(&nt->userdata_group.cg_children);
+}
+
 static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 		size_t count)
 {
@@ -811,15 +821,13 @@ static struct config_item *userdatum_make_item(struct config_group *group,
 	struct netconsole_target *nt;
 	struct userdatum *udm;
 	struct userdata *ud;
-	size_t child_count;
 
 	if (strlen(name) > MAX_EXTRADATA_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
 	ud = to_userdata(&group->cg_item);
 	nt = userdata_to_target(ud);
-	child_count = list_count_nodes(&nt->userdata_group.cg_children);
-	if (child_count >= MAX_EXTRADATA_ITEMS)
+	if (count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS)
 		return ERR_PTR(-ENOSPC);
 
 	udm = kzalloc(sizeof(*udm), GFP_KERNEL);

-- 
2.43.5


