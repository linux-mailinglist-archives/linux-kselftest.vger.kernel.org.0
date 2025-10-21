Return-Path: <linux-kselftest+bounces-43712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F5ABF958F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBA074FFE6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77932F39DE;
	Tue, 21 Oct 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+gt5wjc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291362EF65B
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090441; cv=none; b=iDvmcdfdrEWI2ctjnw2py/tckqAQde6MXPK9ZWxdY8VvahqttgVXceQz+e76byMszpL4v8JzwHV1xKmM08vHAKVoi3imjvssQhjSJfcKoB/sfmDLGb4gggBf2AFovaB4WOumXsnUqb4Ez1PULlXPSPeJ2NkfkzTkXm/YsYj5knk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090441; c=relaxed/simple;
	bh=MF/czfrq9R+gzUXq3nakRInrzOwnmvgXgQyREpFMOsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HsKlfQVvMvSn1J8CNx0l5z28VhOdqan4aw/aGZ5Rak44Si4ADryiUnMc1wU933iOE0keB4q60vha/cCvV+5p4Rel/tJKjy7/XvUhZZALbJlmpQtCrsphQ9Skzf8uzho0qP05uCaKsq8vpWOJrtaQi91KKBeBDkt/HtSH4YRZfv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+gt5wjc; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33be037cf73so4836428a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090435; x=1761695235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6mUZMq9SVTZCVxtIiXitg02c6DGfDqdmAO69aX2eA4=;
        b=Q+gt5wjcUAWtZ1+Pa+QKWygd7P0u+N4yhjAijbU6jC2CCxufGapnDsR1Ijcr3Oi3SD
         ojh9jDqGB0Xnt1ExxkM7bqyKm9mi+xF830Wz1EgVDCSL/rsy/RoTL0qnEis2Y8ls1rO/
         pmqxqOPscZTQEs7Z942VDGmhNBd7iw2TDBokfXWzl2kPtB1n9Es0dK2F/TxAZj72N2e+
         68M+2YfrBnwaKrYKxcwcrHHhkg9gnxyf+9GvkRuJRAoXYObbpqbFd44a3bGVhfVsfsTe
         AaOiI5dmeI2ucyLa0eKl9kyned47owzg3NkYy1ZHB+n3PvC0Jdy2kd/kuntVANcluzAy
         udrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090435; x=1761695235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6mUZMq9SVTZCVxtIiXitg02c6DGfDqdmAO69aX2eA4=;
        b=Mq4t6VvK49ODVkiq6dCezNWzffvNuVFelJVekx6lgdDI7X0qS5CabdcbZD15pN50su
         jKCWkOKMvRBULZhIu9AMY1ohK823yhD2pmCSszX0hKfXWbBl6ul/xDZETt910dO8FBQ6
         S8x6QNtEnqgXiAG4QRxClwIjhb/FzvCLqXO2CFWRfDsRuN4vYt9iuW83airdjY6OdQx3
         /JuvvOMnfEO3FGEvKsKOQsbkhpDHLbJAaGVXRRoKDYIlfrf78Bl2Q9oxM5XPpOV88qaY
         NWKHAlHP9A8dn87c3/cq18nu3mNd95R6xgWxbP12RwY80F9FNADBRyTVyW/oYr/9gx2P
         v9zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZd4i6JWO8Svn6LTmO6lyC7zH10QYDDx4wBkOuv+hOUHl1H/XyBLsdP8tqUx6/t5s3a6Tq8/amyShgpxHxcG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbTxTBBi8wmkFZ01B+8Lrpf+z2Kh90TlelMxcrZlIt3ZgDdFuc
	J9gbLimHpySuGlI1RrTCcFFO9nZX4ya01Oh5zWVN5cmgb8k6ItqIJ0vc
X-Gm-Gg: ASbGncuI9ETTbxNwPBDFwsF/p36ZdyLYBVzdxvnfsZP2TNa/fBwHilUMT8lIVKZoPUJ
	A2SbWcodpgFls0fIaXeu2mz+rsBV6pezKhyLHYZQ0NQiJQAel5UoDHFJMOAGYIhJJn5T/b8r9Ki
	I6eETqn+Hffu+PHEzYyhgqfSSngf0+tx9AKo9b1vODZZOLRFWmCnxsXGFqWU77txr3IwXcu8pbW
	65iSVFVHiGW/w0pbz6X6mRAyaGkyaQmkp/OPqaRibsROKlvO+3vWemeeSnBoqGvaPhmut6AJv8p
	p0Xftz+B4rEoZcNTXSxWO90ogkgfHiBKdKJ2Fqv81B601cL5pAS1xqmzOwBj5I6ubnUhqi3RNbJ
	M7KSO4/7D7tzHRCzZnB08LeCyk+I2I4G6mwl12Z589lu6lqcZO8OEzYVGQq1BuONlyzNxeW2w
X-Google-Smtp-Source: AGHT+IFVbMkOuOiBDnCJEvlMwLaZ7DlmhKs/V/NW1acHbQ/gNGtWZNBni32L0tz8fkkeIan2KaLV9w==
X-Received: by 2002:a17:90a:d60f:b0:32e:d600:4fdb with SMTP id 98e67ed59e1d1-33bcf8e61b8mr21858888a91.18.1761090435179;
        Tue, 21 Oct 2025 16:47:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223e223esm711430a91.7.2025.10.21.16.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:14 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:00 -0700
Subject: [PATCH net-next v7 17/26] selftests/vsock: remove namespaces in
 cleanup()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-17-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Remove the namespaces upon exiting the program in cleanup().  This is
unlikely to be needed for a healthy run, but it is useful for tests that
are manually killed mid-test. In that case, this patch prevents the
subsequent test run from finding stale namespaces with
already-write-once-locked vsock ns modes.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 914d7c873ad9..49b3dd78efad 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -145,6 +145,9 @@ vm_ssh() {
 	return $?
 }
 
+cleanup() {
+	del_namespaces
+}
 
 check_args() {
 	local found

-- 
2.47.3


