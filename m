Return-Path: <linux-kselftest+bounces-43836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C06BFECE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EEA3A967F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5495B296BC4;
	Thu, 23 Oct 2025 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTarZ7Ql"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10092701B4
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181241; cv=none; b=msYPwjWz96jJjWt1gW+PgVxDZtas57JN54/SlKSe0BxAJtVPAOS2SNR4Z6nlFLBUHdCPkslV3NnHJBPKqxWGr5oCSOLovB4H0hM64fhBfiU2WGJ5YJhTGtEI2VGN+qwNcCjJ4zKsOyo37B59G5tNIffBEjM+OwaA4MMeKDd2inA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181241; c=relaxed/simple;
	bh=0gdl78nLUN6qDU9c49g00gHfPsOWu9yWlnAwLxCpxsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dizannantJruQ/pZu8Vz/CbN0JfGQccRIjJkSX+TFxvdmmq/7zD+2RfTkickUJgZenxUEXWfdWcxkX4pDO4cXh4H0XhLk6khJbGtyFvyHikhMxv+lEvCPK6hSoxwVR8nnjUq73/RnqMcD/aSW8CUxX6ZsR/gE/MVI8l0cLkbzvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTarZ7Ql; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so263610a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 18:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181237; x=1761786037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cswws6nw1UcLqOlSgHDjsHbmmRPUE9+8RNFOhZ/bbU=;
        b=LTarZ7QlXgJC0csl3gaT7S9YAatvTMy6Jsm4TgDLsRlWUiJPTcDr4DvaDkSM550oME
         J7LATX+3xtjdP5zJuwb3pr68XHLTbrq/KQ61fdkuVWXVAepqtVo3hpnfehikItxBBnBM
         1wtMthWMtZz5im8pGYOq6u/cgwJPZ23n2K49dwPkrHpxoHXWhaXX1X8zEmNCyeHtflrY
         +US+59b7b+bhkUCBqZ/xnwX1tZ2P2KWpR7+V3oBoOEoyhyjKiqZnQGci5i7geYb+GpIs
         EQWtydSCH51kqpojWNoComjEiA0LdDFqON0LXytY3dBURMJpn+/1ZGPaU0Xq338zq6pD
         DI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181237; x=1761786037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cswws6nw1UcLqOlSgHDjsHbmmRPUE9+8RNFOhZ/bbU=;
        b=EGOF3SGeO9QEZvvO4wv8Lm6e42u2uH7v29pqlhahn13vS1546qO40e6MueoKbwhWcH
         mVY7cLLCfdUP05QvLC/SqCQdd8e6JekS1RQOqCUJe5zj5nhM+VKkQQDlhgmdpW6NhmYa
         z4VjmVQc4wgkxdBG8V7lYM1V9mGGv6+gXVpKVB3dE1WnoHr6wQlJpvdOaVxPAVdB5h8U
         KP2b47ALiemkzkkgrrwQmoyBtIISKkXhQGqORtzynT1u4F1Bni1jEhvhcEMd7H6lpcTK
         vgjTIs3Hry8hYOZhNY+wgLDJ6XDnwNKMIvQ9zdFOiKZblX/DukQCNPk92AACP6EZB1BV
         Jp7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTs2jHHGZvn+r85dxPRYEl+anLYyWF39MBEOpN+gynKgJgDMrSkgyCpSRVLN/DhtaiPOAHC74oT6yqM7NwqRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL34SR/8v3O/HH53fQJX1YRWY2KGqRCCMA1R+Wne6njggpuiUA
	LiX5BogpkmnSQKSdcp1LVgjyYifYghzlN37WQIiR/vaUp6T3DyUjyoIj6QSd0gYl
X-Gm-Gg: ASbGncvLFsy5WzQJRAocYIHBIYpbAi1PaRBmkk/E9cTxZLaMXC/+jDddm9Y1I5cSJKK
	h0Uo33QOSOsq6DB3OuHIseYe5Q8Edw2Vc3hPwBXCSYy8uMUW20yX7BdN09uVc9E3q1xTCvkYZxD
	P4Us1SWeD+wT87C3F/UvJ7gSCCJmJwo4t8HBtTrO0sK+9ls4bkJiT53Ul3JE6fNpqAUvIVlRucA
	IYSh36anuYkcgbW1zsfq1Sz0lsWqGnyGB2pp1jytTwpQdrRok/oqBPtArm3gkl8algjVok2SV2Z
	N/uDgewjX6ZYakLWpbNyIDv9Kl7e16llefybEfDUAwtdf7jud4vvnP0Rlm3qhJl6sGj98huchMU
	Kb2lb7Uwvm4TnfmH1izH5JES8RKkgX7ZXquRo7Tf5I53kl+oUKc+1xDDxTzLctILo0LQPPMBWEJ
	GagzWMj9o=
X-Google-Smtp-Source: AGHT+IHFMWz/k3rf0exIhdMWgyBNfPBQLd//9lK2ixQKJ308LaXrH8yGDSVFtVxEd+3WBYMDTmigrg==
X-Received: by 2002:a17:90b:5105:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-33bcf87a85amr32540449a91.13.1761181236821;
        Wed, 22 Oct 2025 18:00:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dfb67f151sm3310254a91.2.2025.10.22.18.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:36 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:16 -0700
Subject: [PATCH net-next 12/12] selftests/vsock: add vsock_loopback module
 loading
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-12-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add vsock_loopback module loading to the loopback test.

When testing vsock_loopback as a module, it must be loaded before the
test executes or else the test will fail with errno 110.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 038bb5e2b5e2..62b4f5ede9f6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -445,6 +445,8 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+
 	if ! vm_vsock_test "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi

-- 
2.47.3


