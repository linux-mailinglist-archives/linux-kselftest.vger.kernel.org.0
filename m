Return-Path: <linux-kselftest+bounces-24057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C45A05A68
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 12:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CD8165C2D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748111FA828;
	Wed,  8 Jan 2025 11:50:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0561F9ABF;
	Wed,  8 Jan 2025 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337041; cv=none; b=cbrZVmTgfSaKiaI3j+yV5cdywBqCOZw2ygHG+uFSLf7pWtTu4ETSe0VB9HTVe54g1Hg2a/uOUrB41MS0KubSHdHlliUBldkGyB9tlbZtKkSmceknRHlJ6YUz3KuA5LKoJ+h1YvVVnuOllgwvA98Y/Mdo/w5hwWoZVmhYZnlspMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337041; c=relaxed/simple;
	bh=b0dr5T0QwnIxuuEvkRyv8EVkHvyXW4ldpeHd7C+rkBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HmsUK/Mrt9PNuKp8tKaq9nyWjAs7AOemGQ9EvJkC8q2PzygfDoosVEZUtJ8fTyFrC0dxw3Da3h1EknxwPFM65VbJyB+ZtXcNdiMj0nI7nbhMKnj2S7S6+j0lqOwKh/P8GQueoJv1Nsv3tYgnLRm4cAIlucilhUT81mYdaEm22x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso11017563a12.0;
        Wed, 08 Jan 2025 03:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736337038; x=1736941838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Psq5v8QcPJKBmtJbh0DGeIRlVIPLBPUK0VHBQQ4Les=;
        b=T8iQyCFF7Do1XGhEpoSZLlB3dqLZowlqTWp/tEUQsmIsYEH6+p0JbDMdTdYb4F2k/K
         gkMvHvuYC2s4K5OBhXPvzJlyGu/UVlBJmXkXQJWTkjYiFerpoydeTerwm4YxWi340WDA
         djzy4Wp8AI7daPJSmDbMefL1kN3ZOrVBsMHDGTJePfjfMzwRrSkxaiZ8cHsPIWCVcUVP
         paqVexgiXW0uza8kZBtNRl6B+4GFYXqtwFBcHKCAVSYjda6YXIHpVwxyZENAryxIN57Q
         pfpeTZCV984hWQ5pRgUye3xWEGpv+JXMOEjc+iab/ckW51raezrq16j3RZXQ/wDwx0Ve
         iQRg==
X-Forwarded-Encrypted: i=1; AJvYcCXKtUhkeZJj/8Yr6xdDVeCMNLMOjzct+DNvJ+JJpFZbeRM5VtPJG212eNSXipcacwurjXgDFx3i6xMJBCtAuKPC@vger.kernel.org, AJvYcCXVV7BLUUUF9zldzKijuZ/SRG6UVSWwj8S6tiQOIkPQc1YqG9wT7p3NVcPW4MYo3IfxwwLZ71LJPf8VhY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUBjfXepup7p5gamu4ejfUgfUC/8WJ9Hak+oR/5r8QYL+3A661
	rnLaQcPR+s4OZTtUZfzUkaI5QMsubrdPwj5prbCy5m7/mc2OX32p
X-Gm-Gg: ASbGncv6/dz9f5fwu2JhIkBRj5KRY4YRENKF67AWBGRwNZokZjGq7fxW7M2iSzjmCNr
	VDQ/cY0VkYqqzZETp5A+2cqYCeq/TgSYjDQ40ETSMKmbTJgCoGe1Q8bHrl+klkqR9dxznspCy5W
	KKhq+9O/Q7engtRq1yL2rY8I3tsyHQ4NtQCXnnm6f8qyqD0gnG4GVhPm6u86ft6Mp+wyLy9O3qA
	LHsklQ3xMIorw41wDaDsg2SXk4UoNfQoBBd/IZDZ47Klbo=
X-Google-Smtp-Source: AGHT+IFopCOJu21oDNmoL8dIpNxFJc+Y2ey9HhB3yQ4O1yEV8uUW0MjU9SFgmk0F84MMiz2KIKMjMA==
X-Received: by 2002:a05:6402:254d:b0:5d0:81dc:f20e with SMTP id 4fb4d7f45d1cf-5d972e1c5cfmr2010285a12.17.1736337037976;
        Wed, 08 Jan 2025 03:50:37 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d806fed2a1sm26174988a12.67.2025.01.08.03.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 03:50:37 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 08 Jan 2025 03:50:25 -0800
Subject: [PATCH net-next v3 1/4] netconsole: Warn if MAX_USERDATA_ITEMS
 limit is exceeded
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-netcons_overflow_test-v3-1-3d85eb091bec@debian.org>
References: <20250108-netcons_overflow_test-v3-0-3d85eb091bec@debian.org>
In-Reply-To: <20250108-netcons_overflow_test-v3-0-3d85eb091bec@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=leitao@debian.org;
 h=from:subject:message-id; bh=b0dr5T0QwnIxuuEvkRyv8EVkHvyXW4ldpeHd7C+rkBU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnfmaKt0S/vMpwW6p6OgKnXBLS9xdtOqZpapuDk
 tQu/CcpzRGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ35migAKCRA1o5Of/Hh3
 bS4ID/wOOpk4VqlkC2/I80iu/4R1Nc9Usrx0LUlahssak1vjgUqxrAQf9spzw3atgjl4CuaYICF
 AD3/pGCV8+yig7qL3QX05W+Ct6I6drWk/eRNKzFT6KsVlQUhkFhnTOBALnJRTc4ijXn1GDxk/vW
 rHMkcBVu3jruzZHDrNmJwS8X66T8cAD8R9W0wD98IYUEnm3zwj6Zoq7CjPruN/nTcN5uV3n1pzt
 IFziB4/m0jAqjo5u3tOPmsFLZe1BBSiFUzASd3u7akO7jd/7WURBqy2RSl2luWu05J+Nv7bSumh
 80i2wiElapymJ0zFdJRCORMmni4m5IlbtB6OMXNWLf1ZMclf7C/IHlNIPI3uFw0NxmYERYMau0n
 4gEVlOuZDbHqXfbursa+q7kFpNMtbIkVFtFYf1Mo4bpP8dA/iKA6La/j/FF0+QTwKM2GnrEvUHh
 kCL19afZK/9rh8SVPpJ06MMRJGWP/8Wt7G/JKLGisLEAloUiR3jIk5lEE8C5E/9mU8QyiXWyueI
 fdP6ClxXoq0SB2PLLg2cTFyqiPj5VgPvaYIg/Tq0TbZ2zfTqIjUhI0DnmLMt8gdlnwDvCxg43Z2
 pcdDTQn3aFuEK9QSS+9JYIXQ259JQwjEKRbXzkLTDhE/uMo0vnC2pb2kwZm0cc9Vyulq7czjj7L
 2ijLk2cneqjcspQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

netconsole configfs helpers doesn't allow the creation of more than
MAX_USERDATA_ITEMS items.

Add a warning when netconsole userdata update function attempts sees
more than MAX_USERDATA_ITEMS entries.

Replace silent ignore mechanism with WARN_ON_ONCE() to highlight
potential misuse during development and debugging.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index f422a2f666ef2276cf5b10e1dbc6badbc8ef0038..86ab4a42769a49eebe5dd6f01dafafc6c86ec54f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -730,7 +730,7 @@ static void update_userdata(struct netconsole_target *nt)
 		struct userdatum *udm_item;
 		struct config_item *item;
 
-		if (child_count >= MAX_USERDATA_ITEMS)
+		if (WARN_ON_ONCE(child_count >= MAX_USERDATA_ITEMS))
 			break;
 		child_count++;
 

-- 
2.43.5


