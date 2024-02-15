Return-Path: <linux-kselftest+bounces-4777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DF1856852
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08C928EDF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 15:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0006135A64;
	Thu, 15 Feb 2024 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="egrlIkVf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52FC134CFC;
	Thu, 15 Feb 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011877; cv=none; b=gd7pvM4oCL4vv0c2lrmRJUSl9QmgZnbj2TzXLYSDTnEFdVJfr6CNHkVq+TbkLWWbqgjAvhkpacIdHmgbXpck71nHAXBnK75t8JOVqHcz0/1lA4KyV05zWRtxqFwo2PbPLyZ4EYwZ6V20+1BLBFZGc6d5Zl1qQJ4G3rvcLFoJsak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011877; c=relaxed/simple;
	bh=6njkDDjVH7BF5Vtv3rgURx4yvTEOIoCdz9lB2ougXog=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hWeZqoaYrzciH1QO+1u7DqcYBRwZS7HNijFOwp2e8H1u0QAf8/cOHTQsSKKhgomnaUSNyQZtOXadJE7SDwpAGUHanJXYBqM7EcryqMk7ozrdDtPYM365QE3P8Uf63ODZhjMFxqmE7STQI1ZZfCG2t7IZB0QimLyMZDWD/vxeE2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org; spf=pass smtp.mailfrom=xen.org; dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b=egrlIkVf; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=eGccA33nyFEKdgeK/g8u1BZPB0MRYMmxx5o4P3mI8s4=; b=egrlIkVfX67JoHldpFJLL3GD0I
	eYtq30dEdsjEVCpuyXGLNG4LjQMl4eZSODnmvt8roh3JF24Gm7BIq+Hkcak8QRSOFt1YGtnQcE1Di
	Vzl7y+vGzT+N9DYmDNG7JCX1U+LYvwPtK2wTKo/jNMtYFQSkSPI5X8BGkMRji4bPxWbc=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1raduL-0001WE-IS; Thu, 15 Feb 2024 15:44:17 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radhN-00089r-D1; Thu, 15 Feb 2024 15:30:53 +0000
From: Paul Durrant <paul@xen.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v13 15/21] KVM: selftests: re-map Xen's vcpu_info using HVA rather than GPA
Date: Thu, 15 Feb 2024 15:29:10 +0000
Message-Id: <20240215152916.1158-16-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215152916.1158-1-paul@xen.org>
References: <20240215152916.1158-1-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Durrant <pdurrant@amazon.com>

If the relevant capability (KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA) is present
then re-map vcpu_info using the HVA part way through the tests to make sure
then there is no functional change.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>

v13:
 - Patch title change.

v5:
 - New in this version.
---
 .../selftests/kvm/x86_64/xen_shinfo_test.c        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
index a61500ff0822..d2ea0435f4f7 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
@@ -62,6 +62,7 @@ enum {
 	TEST_POLL_TIMEOUT,
 	TEST_POLL_MASKED,
 	TEST_POLL_WAKE,
+	SET_VCPU_INFO,
 	TEST_TIMER_PAST,
 	TEST_LOCKING_SEND_RACE,
 	TEST_LOCKING_POLL_RACE,
@@ -321,6 +322,10 @@ static void guest_code(void)
 
 	GUEST_SYNC(TEST_POLL_WAKE);
 
+	/* Set the vcpu_info to point at exactly the place it already is to
+	 * make sure the attribute is functional. */
+	GUEST_SYNC(SET_VCPU_INFO);
+
 	/* A timer wake an *unmasked* port which should wake us with an
 	 * actual interrupt, while we're polling on a different port. */
 	ports[0]++;
@@ -888,6 +893,16 @@ int main(int argc, char *argv[])
 				alarm(1);
 				break;
 
+			case SET_VCPU_INFO:
+				if (has_shinfo_hva) {
+					struct kvm_xen_vcpu_attr vih = {
+						.type = KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO_HVA,
+						.u.hva = (unsigned long)vinfo
+					};
+					vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &vih);
+				}
+				break;
+
 			case TEST_TIMER_PAST:
 				TEST_ASSERT(!evtchn_irq_expected,
 					    "Expected event channel IRQ but it didn't happen");
-- 
2.39.2


