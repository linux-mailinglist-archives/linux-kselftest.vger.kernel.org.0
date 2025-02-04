Return-Path: <linux-kselftest+bounces-25658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6850BA26FA4
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF27C165AC1
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 10:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC68420AF9C;
	Tue,  4 Feb 2025 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqZw4RCG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59472036FB;
	Tue,  4 Feb 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738666638; cv=none; b=MIZZyuh3vNi3gnbsv5ctMJiBz1LsruOLUj2zCOTUTeI+9kcGnNGnQro2V55uBmTgLX+OgO5ZVYCYLo1qfwORKS3HC6SgtqtbMAvSMeACPdzcv+ElO8NikB7DcJHllKDXdzatvBekL+xGtzLE8CgjoFjSCQ9fNUZuldOF4zNnGEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738666638; c=relaxed/simple;
	bh=RNjGS7mgEJqcXA7DL8UVACMIBo9cTrDb0maylsWm9gA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oTXQRwo0QKpEerPwwrEc7rvPPq1bkhaYegJvpN6+VyerzTNdyAslnJWOw1DP52/5BPVp8qvAnG1lzRBkUPeqMMmloau0pmgitd3AzrftQ0TOIj2/oR4JRmeXDcL2QjDf/8xZKrt2nN5YQtVkqDchFWWZGcwPk4O/zDg3k8bGJac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqZw4RCG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38db0146117so124527f8f.3;
        Tue, 04 Feb 2025 02:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738666633; x=1739271433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tus02b5iZ0nyQ/CBD1r0O4lXL+1fSw/vMEjsRLRNJrs=;
        b=fqZw4RCG/PJXVDHXXUT/DlXKA+w2lAZtA32sydLGE5F11lpNdjivXF/9zrhKyxtmDS
         BQu8IK4SasG8aZn6k2OVuXyuEY6FqwR7IwOQrtFFtw+tYgFWq3XiFaTRK4OpKh5oUHbB
         yWzW3qTPdGvHQhRzpcRGjQUm2xiU/Aw6Q92n4uN7aVdxU2k8Obqe821dKZ2Ea0oFeU85
         6y8vn3kG55y/yTkk1uQB52oluu/O02Eb3fKAUUdYLpQJty4ssbywaDm5BvPZLI04x+Hd
         daNbNu9ZFwt1i/H8O7G/14aBdf9j7szmzPXarNSZz5OSahfwttv3LvtMKgoozSZO/r/w
         g0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738666633; x=1739271433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tus02b5iZ0nyQ/CBD1r0O4lXL+1fSw/vMEjsRLRNJrs=;
        b=O+ahUoO6BfIY5REBFuIEM8Sw1sD5Z5jSCNnkVKkIXuKCoDzfp2k3JJaL4ZE4pvbk3L
         Wdi/NVzTMlPLLqBCKfMrXXoMf6OHiTLFYgg5GYvZEM/MRqeYWmNT759YhYUOiNkW4buH
         6WmW0yYFwcgCB+p+rF4V6Y98jPniJXfGqigy5i57ND3X66MNwzP7oLWHYbrKzbmkGHSQ
         tREjUBsn/HJgkToKrEHqSjmplc2WjwEQdwUtdK3VNmM+6jz5359eYAonPcr6LZwJoLmu
         KvGq+ugEwJ3FPdsDboTcHcqi5XPuvknHn711pjM9f8flMiRrdLsmMt6HSPXquQ8uN0d8
         XRRw==
X-Forwarded-Encrypted: i=1; AJvYcCWicckk3yAvishEbIORyRv6douFPUoigLx7pVt6KX75MWclPpHQ0XX18dLb984cZRpxHLz4KZj5UStZI1xN@vger.kernel.org, AJvYcCXSxkN2mKEu5Xrmfe9mvejbguUdve9r11MlM+afOC0Svg/nNXV5IchP7/qxevHHXoC06Z0=@vger.kernel.org, AJvYcCXdWPxpMPF/doXT198zRDbGU3NpzgoVUz1L+C7vvpiD5/nmSVFz7xROqY2eOSHf+fUOB5J9YGvNFNpxew7gNQm8@vger.kernel.org
X-Gm-Message-State: AOJu0Yylt/K0UpMVrPIkTStDgq2CD4c93HzwvNNBN0o2Qz8HQRtGxbHh
	QiTodo7vsOS6+zM79X2SFF2Qe3OkmqMGVHEa0YzGdNmTYDXZk3Oz
X-Gm-Gg: ASbGnculm9DPdIajGBwdtHvImySomF8J7hm2vfkkyHHwlvgE2EHqgQ5+zkBB2+jybtb
	DHDkwqgT8jN+gwsGRpXZ9CHVC/K72x9+kuBbhwAA37yOl/8BbhLU0cHniv0gi/8kC0VT6L1EuGy
	35fbDWfnM+asitnO8jnsHIHaLN+7dxSTl/td3lsZ0ZUKrLzFtMECcy3vbuusXVobrr27uYRTkcV
	ImCv2CPdNp8e/wdTvbY50eDm9eQcJ+qInfSU7oHWiFWeF3sQS5YnQD0r8VniIG5+jGtzTMP/uM0
	dyzgwvV5QY5PwoxE
X-Google-Smtp-Source: AGHT+IF0yQYgn1KeMRrj96HMVnMbgxJl9mzze5apm3v8uF8Vq00O1FOYPCGWR3KSW2X72TlRvF4HGw==
X-Received: by 2002:a05:6000:2a4:b0:388:da10:ff13 with SMTP id ffacd0b85a97d-38c5195f9e9mr24357488f8f.21.1738666632910;
        Tue, 04 Feb 2025 02:57:12 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38c5c1cee41sm15203497f8f.81.2025.02.04.02.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 02:57:12 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Fix spelling mistake "initally" -> "initially"
Date: Tue,  4 Feb 2025 10:56:47 +0000
Message-ID: <20250204105647.367743-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a literal string and in the function
test_get_inital_dirty. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/kvm/s390/cmma_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390/cmma_test.c b/tools/testing/selftests/kvm/s390/cmma_test.c
index e32dd59703a0..85cc8c18d6e7 100644
--- a/tools/testing/selftests/kvm/s390/cmma_test.c
+++ b/tools/testing/selftests/kvm/s390/cmma_test.c
@@ -444,7 +444,7 @@ static void assert_no_pages_cmma_dirty(struct kvm_vm *vm)
 			 );
 }
 
-static void test_get_inital_dirty(void)
+static void test_get_initial_dirty(void)
 {
 	struct kvm_vm *vm = create_vm_two_memslots();
 	struct kvm_vcpu *vcpu;
@@ -651,7 +651,7 @@ struct testdef {
 } testlist[] = {
 	{ "migration mode and dirty tracking", test_migration_mode },
 	{ "GET_CMMA_BITS: basic calls", test_get_cmma_basic },
-	{ "GET_CMMA_BITS: all pages are dirty initally", test_get_inital_dirty },
+	{ "GET_CMMA_BITS: all pages are dirty initially", test_get_initial_dirty },
 	{ "GET_CMMA_BITS: holes are skipped", test_get_skip_holes },
 };
 
-- 
2.47.2


