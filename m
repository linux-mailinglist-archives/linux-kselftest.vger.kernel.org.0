Return-Path: <linux-kselftest+bounces-35121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6521FADB7A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 19:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB053B34D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8DD288C86;
	Mon, 16 Jun 2025 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ims2SCYu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D06D2BF016;
	Mon, 16 Jun 2025 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750093821; cv=none; b=AgiEXP2OYCUg2WiP5PbuDRi78/WSxuSATDIsv1b//Dz+r+U+Ws07c+VE33CPHbZE8LdCXeiz7kdMbz1CkN8q0IChhkp0yhuFXN8LmY+F0jC1AGa9BP0IyncXSOpRnJqqPLzo7rGyQ9GnKWkXQwqVbTfefeeJDaMoJGyvjcAOdYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750093821; c=relaxed/simple;
	bh=1fykyusYVro73+SkCEdouTI5VeesZrBsX99TGTggxRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EHA3RuQfpUvREYZZapmnC7VODeKLmQcQbJ/YR7tCtEDtlK2XCL2DvqJ0dBfOjAuqdnWFeZhe5wZzrYfRfugw8Z0IvYIvpsHyU3HpuKcwyTpcXY0sLGpZOorGKek0J1sgKKbll1Tr7fdZj5m7T321LdAikN34WMHCc5eTI0Usu80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ims2SCYu; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d20ff236c5so103280985a.2;
        Mon, 16 Jun 2025 10:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750093815; x=1750698615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnKjnGPQVsYruwW26IKQXjP4KtQDe+H/2EepWEDvdH4=;
        b=ims2SCYuni7gGXtPV4Gv3S8d6ijEGdPb6Eu91dihf7+zWnhmAcg/dVHfHkc1dXH7Gz
         EJeGlTBq7Uh+X8bkOzwP/7wL97O8wQV4cGmUu0jwfMutpAwMTaCnBka8WDViywmoRL0A
         ur8OGCxSDfmcGRC4v1MQ/5gFQcAq8knYZvZRPv3hrEmeSqwnfOqi7J8ykvuS0aZURpW6
         azpgK27KqH9FM2KLBXNk4MIEkjLAskhDWEl2nkqEThjkeZC6i7p4OWSuM2U/GW7+lYEy
         9vOVgwPJT2QCgVaJW+IJ7Z6/Mxs1gBRqqTBu7oofDTqnWPE003urkdJi5vKNHbj9sGuQ
         72Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750093815; x=1750698615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnKjnGPQVsYruwW26IKQXjP4KtQDe+H/2EepWEDvdH4=;
        b=M4GtTmKjWCGO/T6mar73xjIgvSyvhW2Bp2XeiQS9UMZXaSgu8yXw6UXEfdLzu7CVXY
         mB6tcM7FZ2XbDFJM9mDq0zmNRqVggcjx2GDhtpfNuMkb2gek+hVmunjFQZxvB3CaZCgt
         6YM+COgp+3doZwOZ6TSh2rh8tJ52wtLz0d77nHhkFTEvIhVWCuaMKSBKwhkk+Y6tWue3
         XyyyYYfFA82Uav/xActQceuA2LIVweGH+3rhSdrICTZ65mQ6/Cam2kdyHuFoJdndfxYp
         oU1yAIevKccorhaYiCPJaYsMPpg6K1GrpiphpMLmqIRA5AHGz9RF9nlv34g/Vy/X1S9J
         YY4A==
X-Forwarded-Encrypted: i=1; AJvYcCU3paDD3YEjfD/q/+jey1LosMwoXIBrNX6eiWbMkWgvVaMYfeYJhpYLiul8nUHUrKrMUqccnM7uh7I=@vger.kernel.org, AJvYcCUjsm8dXB2g1gKXOXSyZuKSSBj1NmAVJS1/Rx8ViEycI29JF2L++Y6JbxRnCsSpZd7eWnvC4AZ2AFMjkFq+mWUk@vger.kernel.org, AJvYcCWbe5F9zeZ/yVfTYLDPfo4+163nYuQ0IobkfchxoqCwAwXQozsk5m4rcTpk1mKf6D+ee+1tGWN6HgMkAe0H@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6DwBD1G1nj1YxCRxGRIVYlnXAHPKjwCIUnH4G70z34YwUNsNk
	FXs7ABGhvo+/kiemXOGJYbaAeoF6Vw6IA8nJU11O/xubXVC6i9GSfSQ1
X-Gm-Gg: ASbGncuJ2k5WQv7gOWSpMKIZ73gDWXTXNL7PeJVetry9MfjmxFO0dGHd4pSMUeWEJ6R
	kiWGaFiuywuXrxUV7dOQnx1fZHyjuvZwWhtXJyC/7/f2Od0uwgVYdBh2DjRC/N/dE9Y4HWh50u9
	o5Dl4sd88E11GeuQYKDiH1pgg2wW1lL3TjlOxzqnOq4LnztRyHiRgNpykQPY6soFUhCOLPz/SoL
	GdRR7s3kF6xqSiO+1EF0JFHE4FIPrI9IjaVWM+3jgojwoHYU9sswLt2ERxMZBuqvIBGfI0/g/yv
	vFapvbAnLWiblHfySGoTyulvZyk+7zszCHB07QIUwzFLeidg0HPCDHDd
X-Google-Smtp-Source: AGHT+IHsQ9BByXp5pGeWBYEn81TAB7iyvrQOQoiCKdS5unwxLUFClfS9eLO2YORgalJfCQUKj/cW6g==
X-Received: by 2002:a05:620a:414a:b0:7cd:4a08:ea12 with SMTP id af79cd13be357-7d3dddd3dcamr28146185a.0.1750093814938;
        Mon, 16 Jun 2025 10:10:14 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:73::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8e1cf5esm546463585a.49.2025.06.16.10.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:10:14 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 16 Jun 2025 10:08:39 -0700
Subject: [PATCH net-next v3 5/5] docs: netconsole: document msgid feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-netconsole-msgid-v3-5-4d2610577571@gmail.com>
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

Add documentation explaining the msgid feature in netconsole.

This feature appends unique id to the userdata dictionary. The message
ID is populated from a per-target 32 bit counter which is incremented
for each message sent to the target. This allows a target to detect if
messages are dropped before reaching the target.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 Documentation/networking/netconsole.rst | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index a0076b542e9c..59cb9982afe6 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -340,6 +340,38 @@ In this example, the message was sent by CPU 42.
       cpu=42    # kernel-populated value
 
 
+Message ID auto population in userdata
+--------------------------------------
+
+Within the netconsole configfs hierarchy, there is a file named `msgid_enabled`
+located in the `userdata` directory. This file controls the message ID
+auto-population feature, which assigns a numeric id to each message sent to a
+given target and appends the ID to userdata dictionary in every message sent.
+
+The message ID is generated using a per-target 32 bit counter that is
+incremented for every message sent to the target. Note that this counter will
+eventually wrap around after reaching uint32_t max value, so the message ID is
+not globally unique over time. However, it can still be used by the target to
+detect if messages were dropped before reaching the target by identifying gaps
+in the sequence of IDs.
+
+It is important to distinguish message IDs from the message <sequnum> field.
+Some kernel messages may never reach netconsole (for example, due to printk
+rate limiting). Thus, a gap in <sequnum> cannot be solely relied upon to
+indicate that a message was dropped during transmission, as it may never have
+been sent via netconsole. The message ID, on the other hand, is only assigned
+to messages that are actually transmitted via netconsole.
+
+Example::
+
+  echo "This is message #1" > /dev/kmsg
+  echo "This is message #2" > /dev/kmsg
+  13,434,54928466,-;This is message #1
+   msgid=1
+  13,435,54934019,-;This is message #2
+   msgid=2
+
+
 Extended console:
 =================
 

-- 
2.47.1


