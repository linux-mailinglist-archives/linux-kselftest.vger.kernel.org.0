Return-Path: <linux-kselftest+bounces-4601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E066853F0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 23:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13871F22171
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 22:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B565263125;
	Tue, 13 Feb 2024 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDxnVPVd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B9C63087;
	Tue, 13 Feb 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864420; cv=none; b=GNuKULiyu1qp3RMxlIN5y1nWV0eNGALYCRv2jaTOpxBbKy7TEU42xPk7jE6i3S8CzC/sA3p5wRjTgFkITVHRutvYR59RJMLuUpt5cWT8nu7mbqV11frs0gnHlQf+hwHUktRcnSL5PHx/t4o0QJgiZNzLgqz2s+ROxjDXerglJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864420; c=relaxed/simple;
	bh=w5VzuQadUGXDHaurnkp1xJatgCg2tWCeQ0RMcYcdwcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UevYwmqFZBYZu88ZTkNlC9fZT+dKvVNHm7LKTPbYU8Gt7wiahLAj4dpP7fgEY25bsdHWF3HVQbnkdcMMyGlREosldcDc6YBRRIKfuUIOeNX7PtZG6rm36YDNIlX4fUC8TLYViJGQX45r+l5omoNHoxOz8WN5fIjn+lUNiv5/3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDxnVPVd; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51176eb6a4bso5076150e87.3;
        Tue, 13 Feb 2024 14:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707864417; x=1708469217; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GNDHPu7XhKcCz1lLARLwTjps5fYGCjGiEa8mM6D458=;
        b=dDxnVPVdYmTOaI0o6bOrZSUHUDe/uZf4T4nZNALLtHMkVbQV5EZp90+LjHXlHjmmgK
         bgeseO9wGslorgEndgTYbO139+rhOqFYYMhC+Qddn74XMNxGmc77CAJVYHJONc5Ezc3B
         30ZpPJz9OFBjB2eqxCbjBJiQbin1wHiJBcp6dbaQuiLkeN+/N0aioAnk6eB7cJUJKljO
         I9vmLyOURiuPL5yPCOmScSVvKiHhnEnxwgoQzDiSz9ELiueFsRr69oNYwRxY4zvzsl1+
         xu4+BGj+rvzVAGnNekyrzrEMx7pLdIKEFn0bxWuQJMfPGXIQwBqPq77KA5GsuMMizxQM
         nxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864417; x=1708469217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GNDHPu7XhKcCz1lLARLwTjps5fYGCjGiEa8mM6D458=;
        b=rUysyB2M+s7c8IUj1303KYj6FfE0zWdWbgTUonaKHiVE3ZgwENAq/ViHK5ib+YV3ZE
         yWebpgBd5XRvCt9ENNUdI0uZCSeXNMiMq3oRAGpzNEZrlGIEGqJZizYaFclFs9ZCDa9O
         tevzPWWrTUYT7xIzulgGEeRE7qbZUsFnXtcYrzvM2sfMhPvWzS/at7lcPzu44+U7Q7pU
         W2R2ChWybAQ+aN44GZgLfPIBYh0DQayKVF2Fqt+79E0j2qZpLyi2II5Eqg4KYhYfQ+N0
         9dX9RyFO3ikn8uIfBn8FuXs6mUIfT5w78mXouukz8cIiwoyvSFfZ/cWr+2O4bLvjPEQ3
         aTzw==
X-Forwarded-Encrypted: i=1; AJvYcCUzbiaV5G2Hfk4EmoqMoC7+9Ex1mWtkb40XgyoCWdLKTGpTN3i938nxQvE1s2YgIAc4Su3tEEUvg1jhdzmh1ok/7Xen+Ylxa5olc14+qKjp
X-Gm-Message-State: AOJu0YwruiWrnE5sDHO9vFJS1RqiVl4zB53Wma99TjTOsK8HjONSZs/l
	S8PIpGBY3dhg7+nUF30L6ApUM3J1vOa6/+8OaeL5qy4DbAK01ySH
X-Google-Smtp-Source: AGHT+IEHYsvYIwoCs15MuLhlYnBbxk1Zf2URRgiLoDNDXog2savoUpfl3HcvHc1Z15aA/MXR5Vmpfg==
X-Received: by 2002:ac2:5e8d:0:b0:511:5537:fb26 with SMTP id b13-20020ac25e8d000000b005115537fb26mr734683lfq.39.1707864417128;
        Tue, 13 Feb 2024 14:46:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNRX+jDMk6q2dQsqOyLrw+8D0mQzGUA6EWKoAPxPYt2wHk5en89e4QoeGhHWhAAzXqjbCoDJXK8S7Vz4zez+b+R9cOivxMe+R6yJJjbRsRuYNJS2SlQDcHDzqlTuoq4hjquInq7N119V7wzNao4P0BYCIjCp9YkT5JzmL6TRMCuYaDDeikYfu+zhHLEY6ux9SDheR5viqT43i25XGV67WL4pceKnxu3twS1u2jLCqC9/QWJ5AAfsr8GTrl/T5rumT9tDR7
Received: from [127.0.1.1] (2a02-8389-41cf-e200-6ae3-bc23-bc27-2247.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6ae3:bc23:bc27:2247])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709062b5100b00a3cd41b3c19sm1700077ejg.199.2024.02.13.14.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:46:56 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 13 Feb 2024 23:46:51 +0100
Subject: [PATCH v3 2/4] selftests: thermal: intel: power_floor: add missing
 gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-selftest_gitignore-v3-2-1f812368702b@gmail.com>
References: <20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com>
In-Reply-To: <20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707864411; l=738;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=w5VzuQadUGXDHaurnkp1xJatgCg2tWCeQ0RMcYcdwcE=;
 b=+mmi/l7xHJvUeyIeLJVMqlGtE+aOmzKHhwa1hRYbYW0CpCwe9MtTKgWI+Q2Z/43Ot1KwCJIO8
 7Xzvv7mgqwcA9oonRXl2u9Sde3J4/J+vOgriqWgGbE48v2ENywHKN8i
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The 'power_floor' test generates an object with the same name,
but there is no .gitignore file in the directory to add the object as
stated in the selftest documentation.

Add the missing .gitignore file and include 'power_floor'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/thermal/intel/power_floor/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/thermal/intel/power_floor/.gitignore b/tools/testing/selftests/thermal/intel/power_floor/.gitignore
new file mode 100644
index 000000000000..1b9a76406f18
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/power_floor/.gitignore
@@ -0,0 +1 @@
+power_floor_test

-- 
2.40.1


