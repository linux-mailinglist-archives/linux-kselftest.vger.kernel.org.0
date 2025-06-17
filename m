Return-Path: <linux-kselftest+bounces-35198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38938ADC8A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 12:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBDCC7A2222
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 10:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038C292B5F;
	Tue, 17 Jun 2025 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN1vbshQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4F0221568;
	Tue, 17 Jun 2025 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157474; cv=none; b=QEbq3Au44DQF13fiqKaqeedtk/N7iINA7eCJHFNc/DoxV4gpJsi5k3FPjcvmyQL/wWjwYVwcVvvi0yfRZs2XchKY7k9HX4nV03BQiY9gnGyoZuemSkNFkNYZ2FXP28wyNRpuiXH7cQqgS43AnCD/bb4if1K36Cl8VfSlliISB7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157474; c=relaxed/simple;
	bh=AYMEFxWHOLCq98+TQyFpfiI60acO/fim7T8QGkgbxJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RgjmsY8uNXqkCVGsoJ9n54yFsQAV0cAdxnK49BQt8ly+MFnZA+WfZc/eQW/1ZYwEHmQLC8Jhr166/G9k3H7JluvdSpf4kdF/GS67k2DENvDGkhIF3EEHZkawIzcXeFmV8ahE0H0crev4JoNBl2yTSZsL97sEtdmmOaX0lXLY0d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iN1vbshQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74800b81f1bso4628467b3a.1;
        Tue, 17 Jun 2025 03:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750157472; x=1750762272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YCooD5TUf7PI1YJO5PSJRlIJLn08pq8F0pRlb6EMveM=;
        b=iN1vbshQy/9cmvmQlk+3aXRClrS9fSlBTKAUufgHnoxkANddfRhzyeLxe8iOgVEAZJ
         TXdj3AG2TaNPQfACZv9m508mlgO0KiLeTLeqEaYUyzy2qezc3mc8Ijv+/hQynKTc4gv1
         2jbRX9VX5u0FTibyiU+eVVtPBuGoN5n4DrN2dyR8J9whYlJbb7XLkdAoIXNpNsIPZv9c
         8HEdKRh14fg+ZrDXPo7R1zV0v38qj0C4uUxPAEFgWBLq0em1QJdmVu5Oo+iIFxK3H0oJ
         I6YOWkc1TiNwfCz12t/N4dEo871DOgv2alglmi1kskr8PU6FhQxmQ2Vh4G7bIm16rwFG
         3s8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750157472; x=1750762272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCooD5TUf7PI1YJO5PSJRlIJLn08pq8F0pRlb6EMveM=;
        b=aAJUD5VMyXQ/O5blKE2xHga9EeXl7fvmXdyc17z7bvj59TxHXZCx2GRYeCdZGYmy+a
         qKB+ISI3dbhSqI5tTFecBzUi0KgO+a0Z3telpebTQ9TOZNztgGb4GAZFzvudopEx502C
         EvsXV3Et/WqN8GhP05dagmEFSqZa3cEscYLA8T8ZYnhUpaNBKYGCNMWV05CSE6q1FpXE
         bNnH2ZbnQ/JPViqbhuhal8vITCNowcDCsgUH8I7n5Osk0jAlSHbnlTwpZnuwGFHYMuiu
         UM/KRPDpyEhXsTabMKTyMWtCRw6wtgcb8fRZ84UYaSjzIU/+Zn3b3YnRXAafEqrahzuE
         zoKg==
X-Forwarded-Encrypted: i=1; AJvYcCXC4uF8LSLZR35uazL15mSxoj5xhtqMTsYqXisaJLUpwFlHFWkMRb2TF4Bgqk+78tN0OgRVMQQTwDet53WYZaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRgccbKz8qk8Ug3J7hc6763BUaNfh5PZcW/FcEND4lgfZ5frs9
	0HuA9YEaDUK+0iEX4pOOg7R5xGgmW8Ekd+EPy+1dv1q/ySJaVYeNs82aG+DAP2gzUPAAmw==
X-Gm-Gg: ASbGncsJUAv+qS1Vl885na7YJohLhsJESwzl/L0RR4J3nBtn78rPgHTdgRzefFtXz87
	Gwq+SFNZmZrLScn71+RvoPekAjPSOwWT5P9DD6J5HaLhEWbY08tvSr0+e+NzZFvn346mSRjRuo/
	kCd2GQ5VZmdOn5RRqfAOlVrmmSIgwolvxKgvDordxNX6/sR06J2LedUTrxztPH9VQodNrlBAY5N
	pfOcFj2us46YVXs09IusBPHPaYHj9RIjLfuqftUAjQNJJvsIBhfYF8jx4Zn8GMmKTcpAkEK/L/s
	8f0Ix6DTBuPAGpHHWnNok8/hc6qipIK4f8QJoNbiURXlFTh7vGkt192PmES0AAVUmorNOGK1CM5
	r7ZNKsA==
X-Google-Smtp-Source: AGHT+IHMrLEKKWT0IE0Pkp8a2/xdA/5e/01YRbQXnG3u9NBBrDsWnXB6DoDNxd3kBhyGA1zGOhvxpw==
X-Received: by 2002:a05:6a00:ad1:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-7489ce012b1mr17532261b3a.4.1750157472152;
        Tue, 17 Jun 2025 03:51:12 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d2e25sm8795739b3a.171.2025.06.17.03.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 03:51:11 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/2] selftests: net: use slowwait to make sure setup finished
Date: Tue, 17 Jun 2025 10:50:58 +0000
Message-ID: <20250617105101.433718-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two updated tests sometimes failed because the network setup hadn't
completed. Used slowwait to ensure the setup finished and the tests
always passed. I ran both tests 50 times, and all of them passed.

Hangbin Liu (2):
  selftests: net: use slowwait to stabilize vrf_route_leaking test
  selftests: net: use slowwait to make sure IPv6 setup finished

 tools/testing/selftests/net/test_vxlan_vnifiltering.sh | 9 ++++-----
 tools/testing/selftests/net/vrf_route_leaking.sh       | 4 ++--
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.46.0


