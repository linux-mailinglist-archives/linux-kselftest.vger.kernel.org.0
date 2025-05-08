Return-Path: <linux-kselftest+bounces-32646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274A8AAF56D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 10:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C8217A42D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 08:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34053224249;
	Thu,  8 May 2025 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqojzECN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC4221D85;
	Thu,  8 May 2025 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692376; cv=none; b=eeciP/VARDOwuEodrVo1fQ/iOOa/WOYThkbbPmnY9A8i1895ztsEOWgCHpjDbgZmGyIQNhjxqB2+xVZ2uh3vtqK5M1mHgRw0Q8d+cFpIVv0q71KkmqYhSJszkoXfHIsm3Egu285Xr1S0zyoGaxWqUzhP45+FCEgNRzMHkLg+D58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692376; c=relaxed/simple;
	bh=hQhbhaO8Zx7OtDKFPagfIJ00HDVkDQ+YZmYffxnythM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8gUkUSeqF/5WE2OHHKF3L2yzvO2PUfJXoMqAV/m6MtOOYM3NzhkVt4uPiCvORfLLwEyq2iVXDdv4RaAACAF25IWdj9fxXnZt2Bb7zGC9XbgEKF0D5y/jlDIm1Bpr/qs7IDUIDjI+vsxHnV0rzVi+uQ/NpVkIYE3ShW/qgY+l9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqojzECN; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7403f3ece96so1150959b3a.0;
        Thu, 08 May 2025 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746692374; x=1747297174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRGCVJPfcsr/8TB6R+WZ33LOVsNeuFhXBOzLDfmrdJU=;
        b=EqojzECNo0cmDgVmYgEcuzJCevct1mz5h93lKyhQ6E7D/8r9EnwMxhXMz/jvV66tDJ
         uUuXrrUPfMMdHeldiJR+9vKQzCV6fewP4RBbbLDICwZB7q4DcX1wgNznJobmN7iuQV8G
         YBA7vDrGtcpErtFQUYmcdF/H105RiuedgzbGqpSCZZu6IkOYynN+qfCg6U88agQeszx8
         AZ08PDZtxmp5fgsPprfxQj+T+ZVPsd71hgg6Ue2GZSylRwQk305CmWHzj9+8zPJWFCzP
         B28VbQ1AW75uj+SMDGMFLNSyANd6p1d+Tuh5naX0QLWegmwFOlsP41Z6ITOwvskkloOI
         ZY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746692374; x=1747297174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRGCVJPfcsr/8TB6R+WZ33LOVsNeuFhXBOzLDfmrdJU=;
        b=RU6sv4KjhjHrpnU4NTrpQ9hDPgPdcuV4LiLLyyowYejoXTz7FKbqqDKsvalG5uI4bc
         wPJsBXiLoplc66dapg6I4Adz3gzm0Kw4rn8MDHXwJ4ItPfX2bLct3PtZwzurKB0OnH9d
         507ZXhZOrwWvngR8TPwUHMshvPOSqqAdW8EFO0QCCVtKoj5fzQ8t9Mu77RiDrrtYajRH
         K/Vev2bWtC/kuQirYUhecrfKHoOyn+J6aYC/+5oF/3f6uJbmlWJECqcBixWLz1Li6x37
         vYOYhy4OiqZ9Gs91P7vGrdpSRGk+clMo82UD+An0coau7I4DfV5IFmJTfUNEfV0sygBq
         an6w==
X-Forwarded-Encrypted: i=1; AJvYcCUooFinUrYIvGlRGG53WFq2+FL+4rugmrXm0/hPBU7BDka4YbeTf0ZgPzJ0MlANalUqIP4xqO2ZAFQMPmUlQaSu@vger.kernel.org, AJvYcCVMh3EaAoN86C7I+Ur0x2V0uNBADbZsRJNKm57hI5mSYIcIb+xCZhDmDt+iDloEo5BfNWnEZhris3ssn65Jg+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZky1h7byorzyv0QYUDx61rI2/5h2uV8hL2rk8MZ5QU7Uv5HIW
	YcvuCkjEXawy3G3rK+1o/OqBoVkdArVS+M9rJlkshyZc46MnSrEQ7wOfFj8kDUc=
X-Gm-Gg: ASbGncvRHEdyXfymBvMTecEJ0aYIpTdiMpLjFStJ90ZqPG8MkFe0CHiLHGncN9v+jW4
	4mG6Sc9+g2246aSzWkXEWQuwraB5K4HIR9pJYR0SLX7+cQ0TwjR5ZipCJ+61Hf8FUbHNMJXSkRo
	+KRbm+ChnI/MT62WmnymxLoyMB6xenpYu+NV+A4OAIdoEpMZH+fcMcdEX6Bq7NAdX/CKbij+Mw8
	W50BtufNkLhhakGlFu9+9UxhbWybX42KTM4jQDjpzP0kSJytO8fkpqzp2klzs3JqwQUhF2ejarR
	wQNLmWXpNVTlxCE9NTPp6Z6+NxhZWJHyeEzOWXykQyCWovtSDleBqy2lImlx
X-Google-Smtp-Source: AGHT+IGROvk3mF2EKqBAktUKZTpWeSfkmo/9ElGFt+56fmbYp3o8/RWNmiaSxns3kTtet6H1mg65xQ==
X-Received: by 2002:a05:6a20:d524:b0:1f5:8678:183d with SMTP id adf61e73a8af0-2148b81ef71mr9347845637.14.1746692373712;
        Thu, 08 May 2025 01:19:33 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7406a36c523sm10907408b3a.144.2025.05.08.01.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 01:19:33 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 1/6] selftests: net: disable rp_filter after namespace initialization
Date: Thu,  8 May 2025 08:19:05 +0000
Message-ID: <20250508081910.84216-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250508081910.84216-1-liuhangbin@gmail.com>
References: <20250508081910.84216-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some distributions enable rp_filter globally by default. To ensure consistent
behavior across environments, we explicitly disable it in several test cases.

This patch moves the rp_filter disabling logic to immediately after the
network namespace is initialized. With this change, individual test cases
with creating namespace via setup_ns no longer need to disable rp_filter
again.

This helps avoid redundancy and ensures test consistency.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 7e1e56318625..7962da06f816 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -217,6 +217,8 @@ setup_ns()
 			return $ksft_skip
 		fi
 		ip -n "${!ns_name}" link set lo up
+		ip netns exec "${!ns_name}" sysctl -wq net.ipv4.conf.all.rp_filter=0
+		ip netns exec "${!ns_name}" sysctl -wq net.ipv4.conf.default.rp_filter=0
 		ns_list+=("${!ns_name}")
 	done
 	NS_LIST+=("${ns_list[@]}")
-- 
2.46.0


