Return-Path: <linux-kselftest+bounces-44769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7008C33470
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 23:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F7B428088
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 22:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443EB315772;
	Tue,  4 Nov 2025 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejuBuseI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DAD348860
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295962; cv=none; b=LTEpJpd9Xp+g6SpgJSXPzyDCYVY6pk/XRytngHA0JZb7uSgBnMktk9ORLjTZ5mnXgBbO/2nU2Npj8Qc4V/sGBydF8iVaj6lb4P7JrRatWANn/qWAUXVtrm3wZyeLN7dO1WLnfaWnAzlrhGgxHHbb0+pNxpTScnwhWoXftELzsmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295962; c=relaxed/simple;
	bh=u5DCKGRI4IXZokQzlkyrjLd6GRAOJx9KYjbavhXUqwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hqeGSlUNJKXO4MGL/ZsDFfYOEuCGc9D2WSXIYYzeKkSDcmXQkt34psDXx0BLA1uJrWtUmuOqne4hD2U7xgWUsrwMP3adeTGyt1ZS9C18xBuZ0E76NefVKgkzGfmqAxe8KWYirRWXPFlk2FiCImJV6TNmFK2zQNj+FiIhjxmjFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejuBuseI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso4404604a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 14:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295959; x=1762900759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnQ+dtcwjsJ29cwDu8qPf9gVDNI9igpgmiF2m60jenM=;
        b=ejuBuseI87JgAOzxRxrvLReQMp0JqqTJuPhOkvguFpn5nVDSO7/KW3d2+gTEIvk/Oc
         AOpa9KH6TvDYhKlesIMiiLBYkMxZtMPHTwRAwRCUCkiBuKKDQF3dFntCgupiT2YJI5pF
         gGd8AaCHIiE/qjqhsZNMMIpgxWZmt2OUSMACWpEVymnRkQZF56QYfBYLL+lm0cx1g9j9
         zuiGhe83Vv55T0wkVszwmb0WqD0CS9KYJ5eiGlBxBtgcCcDzO7eR37ES22neTVCf+Dx0
         ZENQLGCNuYhnuQnecfWarMcK6EzySMaiCnjkZ4C59HODLcdv5jNKo3fxBQHa/mKw68EV
         q/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295959; x=1762900759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnQ+dtcwjsJ29cwDu8qPf9gVDNI9igpgmiF2m60jenM=;
        b=SxFidcWgqiBMjlHLzaZWsALWUL5BFV/FFtRv3iark1Rig0Y83XEMGOx/HgOjxd27Nu
         daIvRzfsjXIzHdD2+LUQt7ZWCKygoewNLXCxSEkzMJ1HC0PB1xNjiLKoEVAtqMvnMKBi
         v8idUEhVGKeRh6NUl66+Rixbn1PH8aXI55pDxfJzqaYZHMvvOD1b4MkMfc2lJKVGvLro
         ZZwEnEoULk+0eZSDsjql1LFJzvnBy+WdzzO+xl8WmSGgwnCwgENHVvWmDYf5kMmZlkzi
         GcCETtmqEDK0R8VTC5Td+PsYW2JJD2Cv5aJvxxhu+Sv0cLDhpBN4Px+oelm283ByOXNZ
         xIBw==
X-Forwarded-Encrypted: i=1; AJvYcCVLza8nYCZjWOZmz8jVSb5MGavv34xI/5HIQ+ku9bw/3PinZgAq1WSA9s2GVephTlKGM2oOylRaJEToRMB8IhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGP5mWeDU0tYAgOEKsMbjxuEvMkzPg+qc97czKu2rWT2EpyYHD
	5cFaSP7T/aAH4Dmlw2YO1XOOP75VP8v9vIWIo+GFyvowsSgPu9SvG1QZ
X-Gm-Gg: ASbGncuG02263wWxS6eXdXG8rk5BOEQ0EP973ZrNaJfNbCGu+mJ3fQ+4yKyNMcva5FN
	KYduvPloW4ovWcSrzs4uUQA6DUjprcskW7Im+NaxLZJJT7rV7s9C5gKAXj99Az7LS2VY1CjRdbx
	zFej0qHZaZyxkrJNCnXRxav7d4Dqa2miUCay5LNoG46W9+CaEN6GW6bfYmdSLrc30NG8QEZnmZc
	8F1jIeS8wAeXl6u1NTH8TEQb+RmelxxIBLJYthZ7qtoWvC3MoxdOhk8vnfLtnYN26jBqVPczJna
	ZcF7allHtQDGxdToN1xYPNQdP6OEiOBXYmHG3dJUll0nYdxVGad288DXg+tPkdNhDJCk6hNx3km
	VEFQ8EycZZIa04C02GcEzOcm9wi9shIwrqJPw19AYYzaeCxuyD84xxgKRRLm1AfyKEpKo6g==
X-Google-Smtp-Source: AGHT+IESw972+NQugcgnm78ZKTviYmRok4BWA0JCtmd+JQgIjTPldLbnjKbimXu6x1kSemHZnD8cAQ==
X-Received: by 2002:a05:6300:218c:b0:34e:63bd:81b6 with SMTP id adf61e73a8af0-34f865ff9f0mr1241428637.57.1762295959215;
        Tue, 04 Nov 2025 14:39:19 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd682163csm4050602b3a.61.2025.11.04.14.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:18 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:39:01 -0800
Subject: [PATCH net-next v2 11/12] selftests/vsock: add vsock_loopback
 module loading
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-11-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add vsock_loopback module loading to the loopback test so that vmtest.sh
can be used for kernels built with loopback as a module.

This is not technically a fix as kselftest expects loopback to be
built-in already (defined in selftests/vsock/config). This is useful
only for using vmtest.sh outside of kselftest.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 0657973b5067..cfb6b589bcba 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -434,6 +434,8 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+
 	if ! vm_vsock_test "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi

-- 
2.47.3


