Return-Path: <linux-kselftest+bounces-45042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EDCC3E09E
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 01:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4258C4EAACB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 00:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5542F9DAF;
	Fri,  7 Nov 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQE3Bjnd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620992EACEE
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476602; cv=none; b=PeiFLRiN8LQNyvD5bLbuEIEzbHoN1fuOeYB+bDDKAdm1n2hts8lKbFbkh9zTOiML9/hHjTlzOGNijhyBnyDBMJ/rmYU8rMIxIAElLCzdT5OHl8YmyhqOqSdLIxRylF1KYzi1uh9WkCFy19Cz/8ua/VDxxoWDkHykfXS9dxNM2R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476602; c=relaxed/simple;
	bh=XXNlL9HT6OWyfD6YaISgyik17zuUQszMD6nW7MMjNu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJ+vEEVggOMF7iLO38u/3pYtrXaZQNSVsTPKOt1a/9ot3ghWJdk/oWBhdywRHU/2iHBBBP0Up5p/HDCmx+1P3Ds6vCdTZI+M5adm7uBBH6PbUSavmzT0Fmq+RVFjH2nu/uxx+tlppeOwgfRie2U8jcAVYcrHY0lfQbpmqoezksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQE3Bjnd; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ba507fe592dso124849a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 16:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476599; x=1763081399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qm+iFGtqs2TRCo1fgFDGUjgedOio+kGkQCN5xya41c8=;
        b=VQE3BjndPzgv6lyChA///bM9XjaIyZ38XwkiNVXX+9r4y8PcM4Jhkk+/aSJplHRzFV
         HmdBlsGLfNoQyEXCEjgrbpqXwculFw1s6unKp47wvgq6zpv0Y2UUVzbLg4AEkFXXoOdn
         lWiassIfPbK2PX7WZaKwJvN3UYVBCUu1GbSllvBRHESgEyzk5IslMqnawW1MBDw0KXSj
         Qypb1jrZW+1TyPScZaBiBjXyS3F257KS2ffSWISLsjfltS5CEYEBC/G4XhH5LDvn9Ohi
         8PYZKtB5j715yHpX8flNbkchzPFocYy03Do487rfkyaIinquJCSsp/T176YOuSx/xS8h
         oEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476599; x=1763081399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qm+iFGtqs2TRCo1fgFDGUjgedOio+kGkQCN5xya41c8=;
        b=qBCVRFA3ZOTqp8WjgQluQFDCQIfAFxp6J6X0wH0dnzCPI4/HFvIFo0yMYlIA9bmYy7
         ssbBQb2RHroz50X4/cxo8dO9O18Awa+gjvsT0SvRWlxY90grMqH9YG4th3vwaaMNpc+c
         sFjOIRpk0JfRR56jlyTxkEH4dTrwOnxtlxUAcBgQxip8CFF7pRbsQH/Vh9ub94VxrZrh
         XLlCL+AkmJgmjkr9YPlRKh481inY3DYy3eO7mkugT9yeXNK2LumcBqEV1I48e/Y3fsIP
         QA5EkB8NL+KxdpXeCuHzZ62Rw9CL10moFdF3733mixdx+3+yhW5D5YT+X5XlkBPHsa4P
         27FQ==
X-Forwarded-Encrypted: i=1; AJvYcCV38aQMAUcBDejp0UByaLoZ9SZ/EXLvgcmT+ErCwGRRXoKpXjSRfevdXpMB/5VhGwwurQX4AQa8Iou0xZaJczU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxixfrFVYLj+/VHRG3CXlaIEKxc/Cw0daiEOBYelAmI0grTfSa2
	YiqBfFCHKWMKwoFosrXyXy5a0MrcivnEMx3LyjM5GDVR1td2GfdXtw0r
X-Gm-Gg: ASbGncu6c1IkBbeS91Ij7+pBWq1mHwVHxCFL7BogYQDs1dB8qCfqxFVxBNgPTZ2hKba
	CSqfxuJUc3Vciq1UU4jurx7nSC+qASICYS/7d3tk8PfVWut6Zj6DZc0mjwyb7RfSTFfu48CfZ27
	3R0aVwkcJp3HavFb5zV+Ud4lxZr/Vte3rFvg1BtJkt15Lb9JLFSNrYCHcaHqN17Osq3KjkkfDcl
	jMd9QtlJnEGmkAjgGBmagC/CrKJJ4R+WObBMVovesQhiXi49ImGUSrHm7kyzFt5yff3XuipUC90
	OR09aTdeSBvzQ1rDS9L2w2uU/bQXT2pbym+SbSaPm68c/oTw782NHfFHX2TkEr/TLpjboXilLft
	rvfLQNhGpQ2y4wjPjKv06wgqf1eDBUgwxj6boIAYLSbfJuTtbboZo/ZRW1F4zWNP/9BaCB4qQNw
	==
X-Google-Smtp-Source: AGHT+IFOFDetHqDrq/PAxGg+NrZQJpCNEyHjtP9cSvBQ0lXmrGvIWZ7Q8EW8bgf8ugBUgQz3F280Xg==
X-Received: by 2002:a17:903:2ec7:b0:26a:ac66:ef3f with SMTP id d9443c01a7336-297c03a608cmr14724535ad.8.1762476599508;
        Thu, 06 Nov 2025 16:49:59 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7c841sm41535535ad.72.2025.11.06.16.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:59 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:52 -0800
Subject: [PATCH net-next v3 08/11] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-8-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

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
index 05cf370a3db4..7962bc40d055 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -559,6 +559,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3


