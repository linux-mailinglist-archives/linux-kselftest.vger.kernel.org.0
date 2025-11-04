Return-Path: <linux-kselftest+bounces-44767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7383CC33461
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 23:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D8D4284D8
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 22:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7FB3491C5;
	Tue,  4 Nov 2025 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZjn6vaH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663BB347BD5
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295960; cv=none; b=S/w3XsEWx9MRKotuj0lA36GkT2nTxXWCWEoWeXjEYEyU3Q10iZIvspVTr6WkmkCtYtqG00g2sixRnC7A9P67pmZ2u04px8PhtLw1b9janPWHDZ2UHGgaR5RtedsZlpu4nNpCyqdIJzf8HOPTYHsg+YCqNqBemTsANCqC1Slp7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295960; c=relaxed/simple;
	bh=7hS5R8uladJKmxaJNfzO1x6DQikjdO3QEQ54fQGP0Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KSXXGxjyMi7/k+FxB8D09RE5XJUSKDiOhe/pHNxxOplDzTIJIt5sjUw9CFrZbTK1J/B01VgjxwYmd53clPHJLAkCq/o3kLFEiwRECAF57R+/3+dFp6Pc0KPAmzGaZWPoDkdcQPxq17nKqlHB2lOrm8aoxvT5ZX2E2tg98UA6rB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZjn6vaH; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so5591607b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 14:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295957; x=1762900757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VT1vOKbccZAqGQoV04Y8d/n2OP/f/9vyCKaFedGSLY=;
        b=aZjn6vaHRogYVyAK/WuCWfshe4SPG0wBvertMFrVtsB7U7WG47JSpNKb6r1IjkAGTF
         TqFsDr/PXwNpJQ7v4EVqkTAxv+3mb61vW6g+KcqcZKpvEXR4hFQUHXEiEBsz7ySexFBJ
         HwE056DDm+6OJnA6fM4MIBNYx9FCs9yaNGkUPEmVWoBsukQhIIUv5eiqyX+GLAlJ6RWk
         Nl8TKvf56vhYfUp/Sh/EpumRRp5URmZV27NmOzvbNkT0i9ZKkX5g4r+Xv35ux3BKmeVX
         1byXklnEmS3K9R36qCgwaCLm9yZbRP5I26OWK/Nn8gEOnhuwyJSIDhpOiTjTGoDx10KH
         Cuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295957; x=1762900757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VT1vOKbccZAqGQoV04Y8d/n2OP/f/9vyCKaFedGSLY=;
        b=hnoPFkegKI5Np3d3b0aGop0kOa/+yypaSBt5wdmj4wmD3lUrsLP3MhpVQq3bZhXzfv
         bnwaBJNzbXrESxiSS2Yl7TDYi6m1/xpfbOwDQj74NVkrFjcDaDrrw+vdOjNgEznLuhf/
         2Md01ax5pwAK2Tca13y+ADEilFykWXoLgsAtk7Xfn58WUBn5Nzy11wCxnILgZL5XJtRF
         AGiZmH5WdaIa80L5+fWbHYiu7sNE2t0Cv9or8elAdPzOJRCTaCr4BhpomcgvBu7RESFj
         mV5b/zOEdA3rpY350rjfc9Czmir6RDo5vmafs3KMlo83salbswEQpVnOu49i+FZMMtkV
         aHbg==
X-Forwarded-Encrypted: i=1; AJvYcCUl0uf+iw43paUhU/YIt/94lvPKNof4iCGcayune0msSkibLZ/Qy/c+ROZDN7cEzp8WipshMC4WskBf1IaFZtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwEKJHXdegiRjI6UmKlPHwL80HLR2rFtRZsd655XL+cP5HrCNQ
	BDIjnFnQhY8IIKp8N7pVJ3D94cF0xuzVmAeVzET/bVq3LIqlnksz78jm
X-Gm-Gg: ASbGncvAbe1iiREInusMeWdPGiZL9/rVhCR1ZHn/hwgpOBrjliIAsLjx+pkdK9FAuHh
	EI+/8r9M2cNVfVd6VhMfWFKvPK8XqPNwJTGioBpdI3TdXK7qVsXVWV2reG5SWGLy7NJWK/MZCBv
	GR37T3pQj7PUQOpob6Vc3OENH2buA8Kdm2ckIIo5WxTgcp9zvRP21GNAboSWNkuGlsQOKzBQtoo
	jwgwQFA1MTdR9nbQvQIEQo74iWqeJm9fw5x9WGa6d+Noodq5TejtxkQhQqI+ptE3/0gLfX0hwhc
	wI8XVFG6PbwidWbnI7vMrHwgCUa0xGwvIx2uM1cQXePz8LnAZWRg93cOmNyPp++fSSVp6lAOrQK
	c7Zbh+uovDm5nfg8dw+OHjiOMr2HA4+ZzH17uosoUiVn+7DrguzXmW+sIWJnMCUVCQib9+8Qw7Q
	==
X-Google-Smtp-Source: AGHT+IEBJAtsIuttdN50ovmDUWQDLmggku0Oz7uskPksnqBRyI0KQxzEkePGlcc8A5fgJ1MA9GtMgQ==
X-Received: by 2002:a05:6a20:914d:b0:2f5:ba02:a2a2 with SMTP id adf61e73a8af0-34f853f6c97mr1247028637.36.1762295957592;
        Tue, 04 Nov 2025 14:39:17 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd392040csm4046430b3a.19.2025.11.04.14.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:17 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:59 -0800
Subject: [PATCH net-next v2 09/12] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-9-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the definition for BUILD and initialize it to zero. This avoids
'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
set to 1 and is later checked for its value.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- remove fixes tag because it doesn't fix breakage of kselftest, and
  just supports otherwise invoking with bash -u
---
 tools/testing/selftests/vsock/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 678c19e089a2..3ba9a0dfdd01 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -530,6 +530,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3


