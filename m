Return-Path: <linux-kselftest+bounces-45043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A58C3E0D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 01:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432FF3B2607
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 00:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82849301483;
	Fri,  7 Nov 2025 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtLhWvLj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539492FB0A4
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476604; cv=none; b=tHrztjhqI0f6YfXYdJKdx3EFBvFpOh7FJwL+eN42Dom2rKcGsC5jxA2vc9QPrVeICMBsZ5+4gbgw1gEmltq4YGtuDTrFypM2voi+LSH919V4HJQpHfWSFYT0YDIgEdqZUTQuiXcJsroOs8Wd4QjsVXAUFamGiVUuH0iBqWSJZqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476604; c=relaxed/simple;
	bh=GxjWMLryYjjKJpr6TT3LeDbeqAWdzd/wbLS6W72CbIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMJFVDjAy2WwWiPIbgv/eaeakspFVQun1pzFBZeVltAIX2izqvXTu2aqnd21qmS/3QSmCVdvkQTEYHG4L6vn6rvlImBGGsqJNevqfvbivvZ7nh9UwO8bJOz3yM10sdlmb/cji2iQC5tJjk271dyyGVnzKKY/WWv4XOUy6W5dBW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtLhWvLj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso327347b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 16:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476602; x=1763081402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DCFKi0aY+3dE4R9e8oh4CcU6zhkT3ckh+srhUdXmfc=;
        b=BtLhWvLjh5egr8867jTIYFHKmFh8IGhbzvAGpiDirzMN0iBfyyhq68ULn/qBkfl4ys
         q+Tnq+nEo4jBLfXJQ/2CgThpT8vsularfbuN+Ig4iN2tGbEYl3myOBvlfFA0Mxh5qPoG
         7eZ3EHc8JCQLGim33EqOhpB/8NPFZTXVyxWqrkGDcCfTDciFHDxrZaVMrfLTy2GbQ722
         Sd3VbK5Npl7PfAvWgDV9GZ1UWNPLkfHZ0d1yJVEuE74+IywQN34iD9j1fFLMWM0Cijgn
         mjd+pE7jqZ9FLXp7ttpR68uXzaqp7eRYtbJZvHfQpQdPM0Og/ZYwFToa+6odyxfw67Sd
         fTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476602; x=1763081402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9DCFKi0aY+3dE4R9e8oh4CcU6zhkT3ckh+srhUdXmfc=;
        b=pCPECbpJamkwSXi5xN3I7AACu7DPhkPLvuDN3wFJPgsnes7PModj3mftARS/YCkw+R
         6XKilGi4FVb5CB0LMsXfQm3D/sIj4XXUrPiNNBykXg7i1C2IDPL8oFiaq7/tnQE4QSBn
         jg9OAEZqhHxAWM2rvGnkF6DJESF2AkeOyE6AlzrKSGDhmYJzZYsEYU+ZoDOO0K+bz6Mc
         o0Au+OwF8P/gDDIzrWS+lFpSHwOoyqwD1Aaup5g7iqxSTrnTXzcV8jy40TvjOsjkY3s+
         fsrNW2R+1HaDOpwYY4xwsy/ZGsLrCCn9JUYBV4DxwrhdI2ipUvUcsIUvpN2NOslp6zqd
         OcpA==
X-Forwarded-Encrypted: i=1; AJvYcCU8TRGURWoVuesdm9TbSiIpFwAODafJ0hmweMnkY1otc9HBtl/7zxSBJFsJ+J0IC4RTlQIkgqkwyd09O3q9a44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVccMtduqf72bWZq8rphsLpCvIiTnAOVA7idgx0WIDSGAjpfQ
	s4bALAHU+MscTIKIDRwodObqpXFPGdMAoXzgbcbBGThvpe0SxiB4AOEnTYejbg==
X-Gm-Gg: ASbGncvzCfbCOWuU0ydKUAqApLH5mhqUMmFOtH6WBHpoXFdvlYl/61h8vCFJbqICIiH
	v2c+6rMS7Tk4v89nrJsws8aAVkzJIPCe1uipOm/1cr6dRPzJXcJ+chCzl8qsQstNisiOQ1BlhIL
	R1pIGhhIFkMQ1WoXc4JDI6rcky228m93xR7aAWOgCZJ/srvisGhsrJOCSOwATNIiM/NMnWkhtc8
	24cMAbqZxd2rBHT2/CD7/eVUEqoBALLTIsuiWLkPinxA3JXjW9PqOJBjZ4KBA3I5mvFC9wABnks
	HQkOHnH5rxX29jnNpLcdy1MaCTIWbQgoV802EKp/VvSddf/lRHk4zODX2V2GhCwEP8+5v8JcKv6
	ywmKENjickg8fQ4HuCf5tc7+kPX9uqx5tuDi3gRX/mUSRSsQGrr39do8pM3zxK6NRWqd3dK49
X-Google-Smtp-Source: AGHT+IGEV5/i8frm9hdbKMaepp45D3BIIaGPeZxpCw61DZpaDradXH7/QyynY840Xwr3dtOtnTjxPg==
X-Received: by 2002:a17:903:943:b0:295:82d0:9ba2 with SMTP id d9443c01a7336-297c0389dd7mr18651925ad.1.1762476601515;
        Thu, 06 Nov 2025 16:50:01 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccec04sm40921705ad.102.2025.11.06.16.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:50:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:54 -0800
Subject: [PATCH net-next v3 10/11] selftests/vsock: add vsock_loopback
 module loading
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-10-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add vsock_loopback module loading to the loopback test so that vmtest.sh
can be used for kernels built with loopback as a module.

This is not technically a fix as kselftest expects loopback to be
built-in already (defined in selftests/vsock/config). This is useful
only for using vmtest.sh outside of kselftest.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a5c33b475a39..cde048bd7fe6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -463,6 +463,8 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+
 	if ! vm_vsock_test "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi

-- 
2.47.3


