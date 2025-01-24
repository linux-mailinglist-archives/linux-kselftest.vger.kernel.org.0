Return-Path: <linux-kselftest+bounces-25059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB76BA1AE58
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 02:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0772E16987A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 01:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108FF1D5CDD;
	Fri, 24 Jan 2025 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YOwDyFgU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8721D54CF
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 01:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737683928; cv=none; b=cRQHc1sHXN8Co4FffnAIiRmBLrY25Aqk32FVQZw5NdT5DRI7EL/1Ed4HvnpCBwUk7KPr6jlTgQsIkOsp/Z9Eac30hM6twqC0uw4BxdmkKbqohwOBzI3rxyOiausDKI4570wcOAImV7NDiPS7d5EJeXQWHgY+zsJZQ5liskXJh7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737683928; c=relaxed/simple;
	bh=mlls54bce+0lvfNSi96vEZ6jU4CJvOJNuNga3KxcE+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xezieit4w/A/C9S4wzU7oQyXcCsTn7v2VJ8O0fTVpIECJ382TLull4hke64LLU2mCl4LdZJkCUxzQZqEvP2tXdaxFRXS3Z+T1HTDP5j4xc5EgoSOiOq3sHdfhTeBFHhFih2bztY6II3yQ9xYSIOHAcRW+cqiosNLFTJQllcmlFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=YOwDyFgU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6ed0de64aso158295785a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 17:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1737683926; x=1738288726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaQdwk1K6JMmpEpTCCMueooCLhtDXZocXZ+0dVMaVq8=;
        b=YOwDyFgUkwUyUl7OAe8ejSuXAMFVvQ5NSXSJN0jOvTDHjVmxxX0cISRJMYJRgOOjiJ
         G5k/PxzFQtJkkzvU8Yb6AROkcowPdlHMq8AlmUmHWwZFjhW1YcR6NDyoV1Zre5+KLaQz
         j70Z0HQzByW3gGiy+XB6L4TwopPb+X0VDBBRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737683926; x=1738288726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaQdwk1K6JMmpEpTCCMueooCLhtDXZocXZ+0dVMaVq8=;
        b=wv/yMc/DFS5SBbOHb8kB3CtgKrb38LcO0f5xG5tc/NXg/9gg4Acy+noTdwasGz6uFH
         ZmFrRXMao3zbZ6EMCCFmxDplaXEjKMYqIn4ESXtyjh75St6gWdsr7+SuIxL23LxpHGLF
         omYkA0Th7gLKXGQ6AxR4OldLxc1sckhTDXq5szHind/34uG57PmR23FNuT1JVxjMdvg9
         sIevs7SP9CfazNNu+tkey2hYZFaK+7SYOIT13zIKxOwVzrj2NLIaMMKvrxcvlEsWQll3
         P/iFkrFe7iplNsV1Gcp5eEgpL2FBRqKjg8fg1q6lVTytdRkApZkDrq+cK8JHmqAZOj5D
         446g==
X-Forwarded-Encrypted: i=1; AJvYcCV9OG4VzhFyAVM70lKdwG5qiXvf/n5rbJM1j5xJvpMxOFX1DtoZpIC40243m7Y4vDI97ZVQT+OKGCJbe4oVo+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRG9/ntNlAT7g476IeUHu0F48WqekVjppj9m1GvbqzpcETPG1U
	1m15aZaXSGCEJKP+QNNrh4KtbSGq0Jh8UninCCBkwyd9n85uSJsbScym6SCKiZI=
X-Gm-Gg: ASbGncuc9ZmjsXMmw68QVzYlMrVcalkyCvalUm3+zu45eLjaM9L3qMiGj5WsumhPcKe
	E7WCIkpRmHW6vZswnbqytSQQsmvkHohaa3SdX+pFLXyxn/1YoFdvdj6BpqKNoe/VvmKHnhJrFHf
	EnQdRsH95i8SsUcs/LsvVPhkDBMwJ2ZwrLEGwdZCUXqctERzOEEeVaKHJ1LWDbAybRSmjEApajb
	SAhk2tyPi51/Z5G2PXx3DS4Dmh9bbc64tO7h2p5qeFmeehPWC45+tbbmL1gEKa+VcNPo/1cAZKC
	+Xtu15AxHfrNIno9UprQy4x26TI79GImgk++lZFNALzv2Tc=
X-Google-Smtp-Source: AGHT+IGedeLyH46JZ6ICjRhHLoRnczUEGAXR32xcGpowOpwEm6uqWspuRRdZr/IOKsIKbb8aqDrT3A==
X-Received: by 2002:a05:620a:278e:b0:7be:73f6:9e86 with SMTP id af79cd13be357-7be9af69755mr301087285a.20.1737683926278;
        Thu, 23 Jan 2025 17:58:46 -0800 (PST)
Received: from joelbox2.. (c-73-251-172-144.hsd1.va.comcast.net. [73.251.172.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8a5fbsm44741985a.31.2025.01.23.17.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 17:58:45 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC 1/5] rcutorture: kvm: Simplify invocation of mkinitrd.sh
Date: Thu, 23 Jan 2025 20:58:32 -0500
Message-Id: <20250124015836.732086-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124015836.732086-1-joel@joelfernandes.org>
References: <20250124015836.732086-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The else block is unnecessary and we can simply clarify the if condition
to remove the else clause. It is more readable.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 42e5e8597a1a..4766c3023fed 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -275,10 +275,7 @@ do
 	shift
 done
 
-if test -n "$dryrun" || test -z "$TORTURE_INITRD" || tools/testing/selftests/rcutorture/bin/mkinitrd.sh
-then
-	:
-else
+if test -z "$dryrun" && test -n "$TORTURE_INITRD" && !tools/testing/selftests/rcutorture/bin/mkinitrd.sh
 	echo No initrd and unable to create one, aborting test >&2
 	exit 1
 fi
-- 
2.34.1


