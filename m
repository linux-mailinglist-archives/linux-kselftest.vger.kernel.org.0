Return-Path: <linux-kselftest+bounces-27170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79852A3F68B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 14:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4FD1890374
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE795212D83;
	Fri, 21 Feb 2025 13:52:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F021146E;
	Fri, 21 Feb 2025 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145948; cv=none; b=o5EC7t/7oS/COmtEoQ0CDdzV0vzl2+wtyhcgnwEfKigpmFiTKFgq4ljoCqn8wP9WVZ4oeJQ3euzcux7ircw1Ut1fNZ1NoaQsE9TX5mXyzCeVNYCDsWfOFfUFMUo9kJqLwzg3HSsR3i2Az9bfqdYrDLllPt3PZyg/UqoibKA1I18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145948; c=relaxed/simple;
	bh=Ob2n3Gjxes2mq/Ts8e3t4uuvkN8LtpNdlLQUukz3fEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tAXpqDe0TeqjpL3jftQYQQr5Rn9r3I+3sF3ynlzpbSTazZUoOFn9tuZ1WSagnmlRvBvRnW39TU5cDorCuJnuHMqFnV8Ko/mj9co9orxIqcBJ7eKiaLoWWGx+wvl80te/MMAyCUcJ7cP1C/rxrElqSV8/r+VldPn4BoCb01FEcvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso4007161a12.3;
        Fri, 21 Feb 2025 05:52:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740145945; x=1740750745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhLoXurUg9nsUH5I3z7BRsf0MsfxSUDScjQg851KMjo=;
        b=xTeLRVJBVmSKCYCtEKI3xzahuCUJu9exMUsjPNhMz200l+CHFK5TtbsXwJ+4lILFdI
         CK1OG3G4r/dTwak27uHLuhsJ4rN92UrRxiIJr8MPWgtqI63UeY20irud/bELETGlHnWy
         vkeecgKZyIS6d2rmJaLE7Vd/Gv/bcpXrtydPh0Fya0tifviXG08ch/VL84974Q/2AOyy
         DitEz0eDcLKWD8+AUuGykHz/BShk1x5vwKyNgk9AGZMY99+KBaSLt/PwgnGJ67bqpieU
         Y3+EpAaVhtq5bCstbug/p8Ol90XvwB5gvaBXTYlI5WZ/VEYf22RjzHidDssyEIiSoTos
         3v+w==
X-Forwarded-Encrypted: i=1; AJvYcCUsNLTbJF+/pSDd5veJVZQTJ+yZKKls9c/3yqmACiKyWvz3UVS76Nydiai3Awh7+xNjFjH865MfO3c=@vger.kernel.org, AJvYcCX6JNSX1++subzc9iAhxwYU1gBRyX4ESzsx2+J4qZjBVOj1SszkS+r58rJc96+/n2NvQdeS/p1/ihv85lCI@vger.kernel.org, AJvYcCX7W7d4gC9KXXTqmNLSjjJv1vrOKST3Y4llcmW5TR2uczu3ydi80cL0mbZHvOeiQFaniCb7E4lgzW/czr+2Rzgp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8G6qq/pPpZPvSAsu0+0hyodVJ8/H6Uxsp8j2X0ckhznhu4YF4
	aWtZOCl2dV29zPGdY52dHWSX1U/40fyw8qrQUTldURhhag1gmLMPbRWI5Q==
X-Gm-Gg: ASbGncv8gIKhcT4gp1d0vQXGvKCGjZylSIjjdL16mwTQjVSJu+B3Ax3TZRVRBZwf+B0
	vd48L8dgH3cpKC1c9TLEK3zdRTuXyXmX3GXbracLfJdjMODeLSBKYZFuQ5ther2CZTPctu6E/cI
	wooOXSN5LOC5W0t+Ax0WkhE3wT/rBGIXXt7tfiT8DnnORH0PQmmf3uUTHfxvQ/VHdI3R1OPd+1P
	7dIMKZ+W9w08Yv6qXD3NfMzmNv1u+6lS9kZK3/4W3uksB8XKSemDqn3KGtownTtJYvTBf2ewpcy
	Bs01bZGNOQuTsm5h
X-Google-Smtp-Source: AGHT+IGyyXHo3KUES95XHnDPWbIM/9t2Rcs2i4ef+6srCMDnYSmMw/LOm/ofPOs8TwXax2JPzTvJeA==
X-Received: by 2002:a05:6402:430a:b0:5de:6bc2:7bb with SMTP id 4fb4d7f45d1cf-5e0b7103f28mr2936975a12.17.1740145944740;
        Fri, 21 Feb 2025 05:52:24 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e09072247esm4257416a12.51.2025.02.21.05.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:52:24 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Feb 2025 05:52:11 -0800
Subject: [PATCH net-next 6/7] netconsole: docs: document the task name
 feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-netcons_current-v1-6-21c86ae8fc0d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2198; i=leitao@debian.org;
 h=from:subject:message-id; bh=Ob2n3Gjxes2mq/Ts8e3t4uuvkN8LtpNdlLQUukz3fEE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnuIUM2R8RCAjq9vUavbVP3mpQxIAhAsHXr2Szg
 ayP0uMgaUmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7iFDAAKCRA1o5Of/Hh3
 bRVJD/oCHdk1nUcH7d6syKrxakso9UyrwJtwZUnnyKRcgzirBpgLO/ZtLlwD0c88LinpUW2TdYw
 bDGuNP7mmAFrgKKJuP0LHNkG231wgf/GJh+vttzPfSiiYRAhlcg1PX9g5sepZZHYcAlEc+xpBJu
 24W5iusSAbN2K8kdEa9EUuPiYn7ywNCA+uQOLCAvp6DUw/eM0JrF3pS9Ao10bbP8WltjxxwtaQR
 P/7KtLMlvUHW63wIa72faiDVti4S+2gS9rZSB+AJq8OQkht5pUSTy2mtGnEKAB4nJRbdgjI5iOm
 JEMuDBwYQBbTcWaAjgz2bNjMJWyFKnDwPBL4u+Sm9T0YhP4NIim8QI9d3jaUh+6e5J1nxNzO/Wp
 Oeqk1O/FNRdnzjqa55L9NbgCHQRloYD4jQ7V+PkA31TkGDON6lAdXH0v2EE48c6M/0u3GXT4Z0H
 PaVtGBsGpKZkdlthE7aQaUvbpwy8+8PNEifm4Svd7uxjGS4c1A/cLmLIYltQW2b4dFB+DqaQQQr
 9ID3JlCXdSeM/XzN1Xh3v3KqmJxbH9WvBO09ldLE4NPY/c/4PQwLzldGJPABXzlaBC8v4T5pf6f
 U//UZeG4YnC1rFj9BB7G2GfftS7b2FdG5/gnkzhKhYQN55FvPXOL0nLhKJ9eLhtQSYlunhZB/UU
 XtJaSr2ptoRJj4w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add documentation for the netconsole task name feature in
Documentation/networking/netconsole.rst. This explains how to enable
task name via configfs and demonstrates the output format.

The documentation includes:
- How to enable/disable the feature via taskname_enabled
- The format of the task name in the output
- An example showing the task name appearing in messages

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/networking/netconsole.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 84803c59968a3237012fab821f432eb531aba45c..ae82a6337a8d8a07a0d691e2da170f6cf70ae86f 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -240,6 +240,34 @@ Delete `userdata` entries with `rmdir`::
 
    It is recommended to not write user data values with newlines.
 
+Task name auto population in userdata
+-------------------------------------
+
+Inside the netconsole configfs hierarchy, there is a file called
+`taskname_enabled` under the `userdata` directory. This file is used to enable
+or disable the automatic task name population feature. This feature
+automatically populates the current task name that is scheduled in the CPU
+sneding the message.
+
+To enable task name auto-population::
+
+  echo 1 > /sys/kernel/config/netconsole/target1/userdata/taskname_enabled
+
+When this option is enabled, the netconsole messages will include an additional
+line in the userdata field with the format `taskname=<task name>`. This allows
+the receiver of the netconsole messages to easily find which application was
+currently scheduled when that message was generated, providing extra context
+for kernel messages and helping to categorize them.
+
+Example::
+
+  echo "This is a message" > /dev/kmsg
+  12,607,22085407756,-;This is a message
+   taskname=echo
+
+In this example, the message was generated while "echo" was the current
+scheduled process.
+
 CPU number auto population in userdata
 --------------------------------------
 

-- 
2.43.5


