Return-Path: <linux-kselftest+bounces-29065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C977A618E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 19:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4DF3BF479
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 18:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9D2063FA;
	Fri, 14 Mar 2025 18:00:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF99205E18;
	Fri, 14 Mar 2025 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975203; cv=none; b=f+R4Y5pCVFVbM4cCeb8aux8NUqbwTsZgOliQFiuvXaco9WzIuAaqtld8tlxlqj5AK6TLe4PFwLCCGPWmjm59fvDhKPGSwilAcwkWL2Q3jQ4ZVf1lju7ZewMbOpN5olZIER1W3lE7HLoivFaWHuqztRp3TeOZbqIbU+jsCFD8ANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975203; c=relaxed/simple;
	bh=u2j/NzYgk/d8iGdvU8IUJdzQd6mljcLDKSOYxuEqFMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iSz5sPCEZXyITB9fyx0oBFsqBZ0WuzhWLrN6NTYvjGMZnfwRy3mHm5jvZz3mlnzZOUYI2DSS9ah7cAvyDU62YP49ZEXsD9PKVciPutLJ9o25ZFdMFW15MqoQYFBnNGb2ymWNUxIHUKTBLk19LSUng779y9HT1vCd/q1Ck2YocLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso494234866b.0;
        Fri, 14 Mar 2025 11:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741975199; x=1742579999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaIvKW2mgl+3uA9xHER8fMViH0sfgfYeNYyYR2PLWqM=;
        b=mP0j/3TRmUaYxxzSi+ZMjKP9Y5uSaR6+HBX1BKqBaKu8MjZiA1vhL7Xek18qjggsW1
         md/h3gkXJarAt6QGh0sUr/v3wN8mUt7oA9/yNmd49O8Lm6UfD68UXDW99hIEpcydGn3x
         tG+n+2xKA4yisB8ZANcTaHo88uPwsoD2zv63cMTM8pEqAQfjL3YslY+bfO/THPJZn7M0
         5Pw7LvuG+XFFXSv24393ENzlnkiw2bqZ5HnZYDhtAwelFYAG9ulyUu4KIS6NZ9368Nfi
         rJeL9O5pbZp3v4J5qwtXK9BFwI7s+22U6aepe3WXqRI6VuFGJW7B7em5V2jYjpsDXn8q
         PQpw==
X-Forwarded-Encrypted: i=1; AJvYcCVFqt+Iu0JFDbLcx5IoqvapcivfL6kTSG2M6cIsz+D8DJ3xfU2r6TUL+KvxTfIpbW/tsK85AUZC4uU/y0bW@vger.kernel.org, AJvYcCW4mo4RNLzRKMbDApvBg7La6MKQ48p2mFqj+NL7SwBk+6t0q6QohU+Qv8ChVVsPmHSLFNwfJhH+ou5pz47QOpSX@vger.kernel.org, AJvYcCXFt72VAcAjxUWjXwAD6mjb6LPIyWYoh5Sfrq+9plI21EsvbGa6RZhfPFJ8/RTddHoxfS9+3kgHV1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVo3q1StCfeeX6MnFGy2vwzT6MsrpUIo0Xquzeli6B8Kgcq7K5
	Uq7xL8kzAQles4qb5791JIpKO0lsq9dzrXzNciWmcR0nwpvpvm2hDYsU0w==
X-Gm-Gg: ASbGncsSjXhwu4PDV61w7nuUdCRJKRfiD6cnhYgjhTZMqneJRrVGyfI3HjkWbSwaM7U
	BoLhd8I6qZuzaiKLRdZUpVbQ3Qx1hhe5rlj8JfJkI2qcvOVTDX2Ol3Y+Uyk3/jPPOZVv5yixBC0
	a//23BXPTL6o6de5lxt8ghcGES/YrPz6xC2YfzTExVjxXcyDR7jBnT9HNJ/DVX7xlBO9CG2AFda
	ONP45fltYvLPHjIOBsHvOWD/WYUvxQPZ0t5CppnO0a0uC+q1bMiuMyVXXEQ/I/OjCc1aMYGwpPS
	X1ZI7XuNBR+J+ZdqZ3nsJnfEoQCRbNs9ZNvf
X-Google-Smtp-Source: AGHT+IE0gCLI1dRzN42ISOI3SznEjuPXbPl3ACCM4prwxY9/ZX0Qybd90r7TKQJmjA7QcpcfBxn4pQ==
X-Received: by 2002:a17:907:7251:b0:ac1:ecb5:7207 with SMTP id a640c23a62f3a-ac330301e93mr384393666b.29.1741975198992;
        Fri, 14 Mar 2025 10:59:58 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147ed1e4sm256125466b.66.2025.03.14.10.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:59:58 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 14 Mar 2025 10:58:50 -0700
Subject: [PATCH net-next 6/6] docs: netconsole: document release feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-netcons_release-v1-6-07979c4b86af@debian.org>
References: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
In-Reply-To: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Manu Bretelle <chantr4@gmail.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; i=leitao@debian.org;
 h=from:subject:message-id; bh=u2j/NzYgk/d8iGdvU8IUJdzQd6mljcLDKSOYxuEqFMQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn1G6SLMwdJ4gjJcxr3mdipOopPqrC5GAx1bakl
 REwxlOE9++JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ9RukgAKCRA1o5Of/Hh3
 bSynEACdkIq8fJbzIuspTFutUJ7ZzO2CzJ1GgNRqCJwjfwjDyF6Wt4MkCQ8s2s1XbO2z7GshqLA
 cmnyIL9lGnkGZOavKJtKUCLbo+tCCnQDm3Qo+JbFG1ObICAzvus+AVfE1285o5JtO8DvK94UVVN
 7I1lBzTVeS4hupscEEKDFA4AfrfvIwzlYYcKi6EPdz6qRU75eyzXxla09izAYIYCV5I35C+R2FC
 aXW/RNsxBDVY40h3T3MbZcuar9v7HDCUiAZZp3aUSlR7th4P7Ry3kvHVnV5TvfHJD8Og1Xs7pKT
 L6Nc4AbbVxTNshwUbmU+l6ofNaEXH7YzbWbpCjGf+SlZD3wN8KnGSUQe5APmU2kfDdsPQ0NaCKq
 XBuVl5eS6lrxYA7UAZyBLx/NkvxFlM/Qzk+8+jVAGc0UPMr6IysS8bARuHFT/mcr3pUQVcnRiMs
 QDlB5dnAO+Kam2PJZR3h9lHeXHcVeN+4nIoHiQQsg/3ifmQ0k95rzt9Nxi64zNwlzE8fSrTfpsy
 92a6zZAwNAvObtitWqsmPS1SaRT8VsoYFe1wZq6iK88nipeCk17lwxA/naVEXcP3O013R2yUrvL
 xQH4xeZasjPD8xDQORNMWz83IhQfsPlDqpK0mBDTYntiUzRT9hVkVnzyZqgzEiULI8bDVVzNSUD
 vkqIMhd+GlV/+4Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add documentation explaining the kernel release auto-population feature
in netconsole.

This feature appends kernel version information to the userdata
dictionary in every message sent when enabled via the `release_enabled`
file in the configfs hierarchy.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/networking/netconsole.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index ae82a6337a8d8..44f5a441cf813 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -268,6 +268,31 @@ Example::
 In this example, the message was generated while "echo" was the current
 scheduled process.
 
+Kernel release auto population in userdata
+------------------------------------------
+
+Within the netconsole configfs hierarchy, there is a file named `release_enabled`
+located in the `userdata` directory. This file controls the kernel release
+(version) auto-population feature, which appends the kernel release information
+to userdata dictionary in every message sent.
+
+To enable the release auto-population::
+
+  echo 1 > /sys/kernel/config/netconsole/target1/userdata/release_enabled
+
+Example::
+
+  echo "This is a message" > /dev/kmsg
+  12,607,22085407756,-;This is a message
+   release=6.14.0-rc6-01219-g3c027fbd941d
+
+.. note::
+
+   This feature provides the same data as the "release prepend" feature.
+   However, in this case, the release information is appended to the userdata
+   dictionary rather than being included in the message header.
+
+
 CPU number auto population in userdata
 --------------------------------------
 

-- 
2.47.1


