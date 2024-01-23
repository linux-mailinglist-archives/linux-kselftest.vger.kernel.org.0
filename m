Return-Path: <linux-kselftest+bounces-3406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F42838E7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 13:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C2E1F25266
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 12:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E3E5EE60;
	Tue, 23 Jan 2024 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="AF2agY6F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3A5DF33
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012886; cv=none; b=uioRGtdVdROjQVnhcoxbqShUhvAxnJUU76syAG68QeBNDu2ZvMBNaGTBVTVATVyBPGKt7+QcVr1iSYogtioWAE9zCjLLUEy1wJzp52Y7jiwxvmlFODRSr0IwVjXQZRkuQa2QJB1MDUJ/Ll7OSm94PVOxivL6XvUKxIxY4BD06Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012886; c=relaxed/simple;
	bh=hNio0nD1Jw8dvozmdpvI20LoAzPAeMst7QlmZwbRnt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QT+Zv7jNMXJtzsubq0P+gCVoXVOVJR9xmqbTbpVTIf/gFyIAVESU6DuxRPXhRW73SOmh3xfDqMI+jlpZLXNLJ5aHRF8a4EoD1yxJnM/FJjl4MhzyOv0M5o859C9JfDfp87nnmVrmB0wB1vft/gAi3fS3g0JZaptnBqyJ9bev7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=AF2agY6F; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d711d7a940so36283585ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 04:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706012884; x=1706617684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0aWr6I4AG0v1dbSwbiagBcAQfQgpKpYJbEuHRWpjLo=;
        b=AF2agY6FiEtmXolpgqZJSdLqAiQ+Dspdc7yI6uQs5Ka5yaJrda92dZp+UppPehLwaK
         xCawr+uyRfZkdlFCxfmue3lK2EMa8n4cwP1mFzo+hMr5OQqF1i6appASEm/njL3SRsSd
         JsJMrUSA5Yj+lKZfDN6Q2X+8kQ1qEV+NsCPVmuizwmYbjmVb3/yotNLsaWBSNgokdIog
         +07RdzCzIsKNMDdb2OLjqGAu33M6D/mjIHk3QNpTCxPAisQM7rfnPNFQER8C1Q9qwH7e
         omb447PjiBb5u4+00cq/dA099MRtIsplMYNUoDZStd3IC8Y22l7G61ufyHih8nM30biM
         BtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706012884; x=1706617684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0aWr6I4AG0v1dbSwbiagBcAQfQgpKpYJbEuHRWpjLo=;
        b=CMuOUrsFkDKgPYPLtmVTBoxGIhulps/3X6lHrqKl1Z1k+3A/0DMDlRSdjEu1qXnDin
         oeS82xXOoZEzLWHL8f/Kpsk6pQFAUXycNulDTH6UxpSze3kOKXNuz9Ac2ZZeZBiEAwdw
         fbW+i6o3moBc0ENRn0XeqOcOZZrp6DA2W6MJkwb9+RT0qXNipnPv3ULNdZ4CQt9n2D65
         dbaQsORpXQcIOaO7+0Zkt55BmKaM/GUKaS6rWDMeXf/1NZMU7cYqdCkrGnqoHxw/UDep
         BPSIbx77W4FIZ7mOxTLPNFWRQ8bLvlnNhxmllBeluf+vPraL982fOYDvlu+6e03nHxUC
         A1nQ==
X-Gm-Message-State: AOJu0YyQhJZCIeIlHyc+qe5VlE28XI3L3EusWVX9EtmqYGuGOCzqCk+Q
	EpRpF2XjnDAmFAtw7GYk9m5bVRP7k3fyvaCyZdA1VqrWMy4RFjkFFT3toYbqSiXBQ4Y5ek0Ub2b
	/uA==
X-Google-Smtp-Source: AGHT+IH+j++0Z4LJicGfMhDn4wsXWvlBrkFUYpvREu0saz7SbxcqHQ5+aTarwo0UXzA7phAzv9xZSA==
X-Received: by 2002:a17:902:dacc:b0:1d7:6feb:b0b4 with SMTP id q12-20020a170902dacc00b001d76febb0b4mr562706plx.19.1706012884519;
        Tue, 23 Jan 2024 04:28:04 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id ke5-20020a170903340500b001d33e6521b9sm8867643plb.14.2024.01.23.04.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:28:04 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	kuba@kernel.org,
	vladimir.oltean@nxp.com,
	dcaratti@redhat.com,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 1/4] selftests: tc-testing: add missing netfilter config
Date: Tue, 23 Jan 2024 09:27:33 -0300
Message-Id: <20240123122736.9915-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123122736.9915-1-pctammela@mojatatu.com>
References: <20240123122736.9915-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a default config + tc-testing config build, tdc will miss
all the netfilter related tests because it's missing:
   CONFIG_NETFILTER=y

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index c60acba951c2..db176fe7d0c3 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -8,6 +8,7 @@ CONFIG_VETH=y
 #
 # Core Netfilter Configuration
 #
+CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_MARK=y
-- 
2.40.1


