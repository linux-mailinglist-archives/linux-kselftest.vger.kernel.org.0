Return-Path: <linux-kselftest+bounces-39019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15463B273A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 02:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E892C1881906
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 00:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B7E2D052;
	Fri, 15 Aug 2025 00:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFexyq4o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A4AAD2C;
	Fri, 15 Aug 2025 00:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217126; cv=none; b=oJj7v5bgOeIySRkOdTlzXjrIraBOIaucFYF0qs3PDxvlyy/YYN1yc3fyPgmhZ+xVw7aIHp/9oMzR23kSZpoeDr86dydg2DZ3u4DMWukr+Z9kTj/A4w9MtmVQILgGF8IDS7B8DtTuttsKNtN68auqLwVNK+zVp8BtU9zIYNmALC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217126; c=relaxed/simple;
	bh=YSHQ0nHVRPFsB93Dabwiu8ozEATJ/8Mr0PnXcpCB98s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uvkhhDFAQda5cdgEGqIp8WaFNkgFhLATKhSFTQ86XwTd56a7vRJIo5/oAkjsPvgwwmXtdoQDrsDHalqTKQ733TewL8JzgVwDzahCiPivB0YX74qiDSHfmwSGml3Y40XwFTxvJjTAU3oWJd4knCZlV74jgYN8jIDopH2ocHRm0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFexyq4o; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2445806c2ddso12760205ad.1;
        Thu, 14 Aug 2025 17:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755217124; x=1755821924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHJYqmfxyB1ZtjnaSlG3/Xthq2PX+hi9aHfPk8z27kw=;
        b=WFexyq4oXTNdVCrZZiWbVQWICwor/oZkoM5a+veKqbKqwurJx7uhZ1lYL7puFPtM97
         T9rvtKBJAsYbiHPn63d3J5+bbBiw3JOkp2I5WjT65ulmhzGK7EPEuPIluAK96iDejfhv
         V2zPkZOtGQJTbHBBVMZWjBWl4Pwh2CJmtMfswCXNMjjAr13b7E8NqO6PpeUZkbigKcoU
         KCx41nRvW9HWFqPnSbMqwTM+3kzZD/gCo404E1fvkLfi33sR6GkzSP8tpcwhRB/jGulr
         CrQI7Hy6dkYHh94XLaJXUeZxntwpyC4mGACMvVe2w2BJWsbrQngtjjNb2jxDouVocTW6
         N1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217124; x=1755821924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHJYqmfxyB1ZtjnaSlG3/Xthq2PX+hi9aHfPk8z27kw=;
        b=fv/h0ZocVsAzylqVdIiVCJm7Njf9CO019WUyVyf9YCGzUOtnpykH48Aav8HJdBlE6f
         t4SSn8CLHdNrgjKfBd51EKcfDT6DAu/jdBHPx8sEpynKgwiScaJlojXyVFBuWFj8RyFZ
         Xg/ZrJkZtOcYpLGVoEDpvvJ/CEOcc7E8F3SsfMx2ypHzgX7ayK/QB6ZXqptCCoiVBoYt
         KudqcbL3QKThCHiEJN6vAl1sHVrP9/eSLeIrBdLQRc0QGzGiaNKj49fBSOwA5ACbFZ7x
         Uki4GpRVrst+npYdau/uS34yFRg/I05X0iMwLrRcnAfaVKNYLBOzFwJarsJ3nZptbLEg
         Kz5w==
X-Forwarded-Encrypted: i=1; AJvYcCUgsoaZJDIKYGuq2Q0DHSy5umr7lfOGavRJnrK4/oJjDZ7yjktXO7NcY6rhIYsjGOiSHwQvW42d@vger.kernel.org, AJvYcCV4waBbTfD4Kkdkk1wnxhUSzyamXEVXdNwXaBz8niylaEdA1hyX3tPda6NrdXoXPReb4pfHbUjP/tMEt30=@vger.kernel.org, AJvYcCXLZjodCsSgcUl8tE8iPs1zu3sq8ChXlADdwlsC9A+Cbed9JXOF+UMfQJzc/fQXBVAWkdnDsxtNUrc0AmBbLb3w@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7/w21cXwyEVBgu190U6EzyxA9H1Z/4kYLIzhuN13gmeGj9bNW
	LLv3CqJoEzQg21bP+qLPQdoNNPEm/vN2vejvp+i8IZatxaJu0CtjrVq35nSHUjk/2aY=
X-Gm-Gg: ASbGncu7B24+ECxypbG1xrmTpi2ibcWRBw3zgypmr3tllKzAmXxAUwJ9KS9aRUwYFFT
	F44g6BfJ0Rw3WKTbb3FhR+2BP57aPdzgcSC1fjI3xgz9zerEvKCHtmT0p8F1SLkyeNIkFxGoklR
	5CFu2oQnUdfTp94GnB4v/a/dGPxSVJuToiAadL7vs2vyv/fokyR+NR10Um1eHprpNUl4JA7XU4n
	KB1tDlAfnWPhXZ2XyrZBtVV25aNPTRCr6SZLZExYDxzjlXLO/BWo+Ujzo43lAMN3TR8g6XMjg9I
	AeXb11/kPnwlDBOBj6kt8ucmr05XIXq87X5EbXBUb7MTAfjaw5UaUG/jKUFd/hubthmsn6EEY62
	dtmFvQ7WvT99kd6t2ipeqSw7Hvw64yx2i7ms/k2ty3Q==
X-Google-Smtp-Source: AGHT+IFxzhdphiJBS2G/UPMPzKz6foyjIJZMPLW6JxLo23pShrslemm4KTOWFETkoXre0puhmLRAcQ==
X-Received: by 2002:a17:902:c947:b0:240:aa0:1584 with SMTP id d9443c01a7336-2446d8db8f0mr2125065ad.38.1755217123642;
        Thu, 14 Aug 2025 17:18:43 -0700 (PDT)
Received: from soham-laptop.. ([103.182.158.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5a451esm700745ad.165.2025.08.14.17.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 17:18:43 -0700 (PDT)
From: Soham Metha <sohammetha01@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Soham Metha <sohammetha01@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH 2/6] setftests: net: netfilter: fix spelling mistakes in output
Date: Fri, 15 Aug 2025 05:47:59 +0530
Message-Id: <20250815001803.112924-1-sohammetha01@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815000859.112169-1-sohammetha01@gmail.com>
References: <20250815000859.112169-1-sohammetha01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

found/fixed following typos

- add add -> add
- cannnot -> cannot
- fowarded -> forwarded

in `tools/testing/selftests/net/netfilter/nft_nat.sh`

Signed-off-by: Soham Metha <sohammetha01@gmail.com>
---
 .../testing/selftests/net/netfilter/nft_nat.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_nat.sh b/tools/testing/selftests/net/netfilter/nft_nat.sh
index a954754b99b3..44a8fdf5c19c 100755
--- a/tools/testing/selftests/net/netfilter/nft_nat.sh
+++ b/tools/testing/selftests/net/netfilter/nft_nat.sh
@@ -164,7 +164,7 @@ table $family nat {
 }
 EOF
 	if [ $? -ne 0 ]; then
-		echo "SKIP: Could not add add $family dnat hook"
+		echo "SKIP: Could not add $family dnat hook"
 		return $ksft_skip
 	fi
 
@@ -239,7 +239,7 @@ EOF
 			test_inet_nat=false
 			return $ksft_skip
 		fi
-		echo "SKIP: Could not add add $family dnat hook"
+		echo "SKIP: Could not add $family dnat hook"
 		return $ksft_skip
 	fi
 
@@ -418,7 +418,7 @@ table $family nat {
 }
 EOF
 	if [ $? -ne 0 ]; then
-		echo "SKIP: Could not add add $family masquerade hook"
+		echo "SKIP: Could not add $family masquerade hook"
 		return $ksft_skip
 	fi
 
@@ -509,7 +509,7 @@ table $family nat {
 }
 EOF
 	if [ $? -ne 0 ]; then
-		echo "SKIP: Could not add add $family masquerade hook"
+		echo "SKIP: Could not add $family masquerade hook"
 		return $ksft_skip
 	fi
 
@@ -569,7 +569,7 @@ test_redirect6()
 	ip netns exec "$ns0" sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
 
 	if ! ip netns exec "$ns2" ping -q -c 1 dead:1::99 > /dev/null;then
-		echo "ERROR: cannnot ping $ns1 from $ns2 via ipv6"
+		echo "ERROR: cannot ping $ns1 from $ns2 via ipv6"
 		lret=1
 	fi
 
@@ -598,7 +598,7 @@ table $family nat {
 }
 EOF
 	if [ $? -ne 0 ]; then
-		echo "SKIP: Could not add add $family redirect hook"
+		echo "SKIP: Could not add $family redirect hook"
 		return $ksft_skip
 	fi
 
@@ -673,7 +673,7 @@ table $family nat {
 }
 EOF
 	if [ $? -ne 0 ]; then
-		echo "SKIP: Could not add add $family redirect hook"
+		echo "SKIP: Could not add $family redirect hook"
 		return $ksft_skip
 	fi
 
@@ -844,7 +844,7 @@ table $family nat {
 }
 EOF
 	if [ $? -ne 0 ]; then
-		echo "SKIP: Could not add add $family masquerade hook"
+		echo "SKIP: Could not add $family masquerade hook"
 		return $ksft_skip
 	fi
 
@@ -859,7 +859,7 @@ EOF
 	# from router:service bypass connection tracking.
 	test_port_shadow_notrack "$family"
 
-	# test nat based mitigation: fowarded packets coming from service port
+	# test nat based mitigation: forwarded packets coming from service port
 	# are masqueraded with random highport.
 	test_port_shadow_pat "$family"
 
-- 
2.34.1


