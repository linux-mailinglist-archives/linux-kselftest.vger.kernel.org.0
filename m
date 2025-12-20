Return-Path: <linux-kselftest+bounces-47750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5ABCD2592
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 03:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3C4A30184D4
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 02:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB16C2EA749;
	Sat, 20 Dec 2025 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pooladkhay.com header.i=@pooladkhay.com header.b="AYDiKpyM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.qs.icloud.com (p-east3-cluster6-host6-snip4-1.eps.apple.com [57.103.85.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A3F2E0926
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Dec 2025 02:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.85.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766196677; cv=none; b=uRM/gcohr7tXy6COWFhGWbNVfOMJSfFcRIBYdGMMZb0ZJ+iJs5oR+uZ8r/8PcGBQHNg1ZTLB9Sg2yUkb11Qdi7XXtqGweP4zMcdwJdmRnLydTbfILHJickYRw+Wv1+qDVZH7lAlNxieHse/Zy03Ir+Wcg5pkD8TX7YTjgGGWIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766196677; c=relaxed/simple;
	bh=M5zIZxyX3vJfnlru/qogq4ie/BJBDwXUAUKpVTyat1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idKaTcSYoUM1eDnqJzQvlzuPloBihmkE9WvVkO5r0Mb54ze+wemjDa0JvLVHxTm9sWCOZJFz+4Gpr1xegydRMAYzLbtvhsZR0VSKfruCM4ztuzIIeRy2H9zk506InCqZmsEegD1ryasy51kPSEsdOtHIIuaziIWuVrnv4aEbWHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pooladkhay.com; spf=pass smtp.mailfrom=pooladkhay.com; dkim=pass (2048-bit key) header.d=pooladkhay.com header.i=@pooladkhay.com header.b=AYDiKpyM; arc=none smtp.client-ip=57.103.85.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pooladkhay.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pooladkhay.com
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-4 (Postfix) with ESMTPS id 666B418000A6;
	Sat, 20 Dec 2025 02:11:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pooladkhay.com; s=sig1; bh=vKcDOVLwTHpYjAOxbDjZNRdPCGR97CruclmfjlgLv3I=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=AYDiKpyMk/KFzWe2+6e9rx/qiseyqgvpTo1HMdCso53VkRHhXGgCXHfu/GScuqAe7zOmJ2fPKB5qZBPHzMw0xCRwRgrvSVBsUIglxFsu0+nmeDSXh7DUYsYLNVkQAHYMl1ZI1pFCLuavUwORQY4/PfHxcFp+k3capvrHkrBS9VfW0CgsrIK2ejZihJ8M0iPr0KsdBdTYOK+neu9wWRA2hiNOubTXuIiFS3uCNT/tpT4WELlHtdGU/YJW4pH9Jxc+QJRmN2opr8ZUo0uXzGELuvZ98XEY8cwdNY2puZ0tXbrKv82JRkf7dHm6IK2HCygk7faHOfvDTAXwWPHsOZG9mA==
mail-alias-created-date: 1721833214903
Received: from fedora (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-4 (Postfix) with ESMTPSA id 7DC6F1800132;
	Sat, 20 Dec 2025 02:11:10 +0000 (UTC)
From: MJ Pooladkhay <mj@pooladkhay.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: shuah@kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	MJ Pooladkhay <mj@pooladkhay.com>
Subject: [PATCH] KVM: selftests: Fix sign extension bug in get_desc64_base()
Date: Sat, 20 Dec 2025 02:10:50 +0000
Message-ID: <20251220021050.88490-1-mj@pooladkhay.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=EvjfbCcA c=1 sm=1 tr=0 ts=694605c1 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Zm6OpU2aAAAA:8
 a=LkGu3Il3C3kqsxVw9RAA:9 a=7OHkOZIn_5tYZgECawIR:22
X-Proofpoint-GUID: -i5TUfmSSksG7sSoaynImRLKo7Q41z3E
X-Proofpoint-ORIG-GUID: -i5TUfmSSksG7sSoaynImRLKo7Q41z3E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIwMDAxNiBTYWx0ZWRfXxscVuSWhNrkR
 FoE0ydymLVyCBB9jTIYAx+iHgqRABb1yOFa/k/quC+C89w6Ss5Uz/a4sm7D5/vWX3WxGcA9Bmxx
 AlPxSA9rE05ZkxJLINJIba2RePuGZnTZcqXXssAewC03+mg0isxb/ArvnCMYtOoXi1cHSrp5ukv
 HEKwKqhLnOelFhr3z30ePoOx7KdVBuMF6SVpmfcJ45IN4V6z4FSpxcesY9h6eoTcZNsTM5x9dpM
 fT9CRGA3EKpFEIwjkRgFtrrVRe4axG3atSsNz+OFOD/tIaVvnPNQyTRAb18Ay5truQEc7v6wkzv
 KzS5Xad6yijxc8bneFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_08,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=843
 bulkscore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512200016
X-JNJ: AAAAAAABpW5oZWeKHJ+Gckjv9yi0Nrl7aIWU8LNKPg80BZ0UDO3G4zT9gUlkfxSm0O7xuuaccKOIvsTu4JoEfJbvNvEVgtcT8HXtf8Kugq24lm4vba78Ofur/7BdzhkFFf5RcbvmoIBZK7dzIUYLEQ+4yePpGIUZHcbKdyFKUzhZ4Lk3nzr5zuin4bKzsjAecOXeJ7k121asQyYICUtVpx9lwK4CSLNaUrcdgryec7+bp+j2MSspm/AbrgWDKQe+vzCm9VkQCwOcxXZmp1DtFrfnqc5B1oKjqd1XFgAzzplhrVzhM+H1luv6UdcaZzRxcI7FY9FrA+hOPmUM3HjiaSytpfiEPUNlSLqFMNlUbBVSo1yvS/b9lJZdnozZUpEZpnX948wQfpPlCU5Kt/vNLwQngSrb63TIKUpnVtDK4sD+gz+Lt7Hun10m3OpcxCW9s/1ZcvfeFVQFWZG9hEgafTWlfICV4gEDGtatooLFbEMLoOck87M+AG1mfObkQG1095Jj1vT/U147fqqXfE8wifPK9eLyudeiVUXr/hZAYnh5VbokZ/b5ETJSJrGm+q487PffQu6+a7rYKF0wHP2G8wGZg7CqTunTkRXS4dPPcUwU9hW7u1PwF/sylNwWNrh/Z2nNUcdXTAv6fRMhCRTyr7RCra8Nw1lHygN4NIdAvbT3AgR/GJiPjR+N5kA=

The function get_desc64_base() performs a series of bitwise left shifts on
fields of various sizes. More specifically, when performing '<< 24' on
'desc->base2' (which is a u8), 'base2' is promoted to a signed integer
before shifting.

In a scenario where base2 >= 0x80, the shift places a 1 into bit 31,
causing the 32-bit intermediate value to become negative. When this
result is cast to uint64_t or ORed into the return value, sign extension
occurs, corrupting the upper 32 bits of the address (base3).

Example:
Given:
  base0 = 0x5000
  base1 = 0xd6
  base2 = 0xf8
  base3 = 0xfffffe7c

Expected return: 0xfffffe7cf8d65000
Actual return:   0xfffffffff8d65000

Fix this by explicitly casting the fields to 'uint64_t' before shifting
to prevent sign extension.

Signed-off-by: MJ Pooladkhay <mj@pooladkhay.com>
---
While using get_desc64_base() to set the HOST_TR_BASE value for a custom 
educational hypervisor, I observed system freezes, either immediately or
after migrating the guest to a new core. I eventually realized that KVM
uses get_cpu_entry_area() for the TR base. Switching to that fixed my
freezes (which were triple faults on one core followed by soft lockups 
on others, waiting on smp_call_function_many_cond) and helped me identify
the sign-extension bug in this helper function that was corrupting the
HOST_TR_BASE value.

Thanks,
MJ Pooladkhay

 tools/testing/selftests/kvm/include/x86/processor.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 57d62a425..cc2f8fb6f 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -436,8 +436,11 @@ struct kvm_x86_state {
 
 static inline uint64_t get_desc64_base(const struct desc64 *desc)
 {
-	return ((uint64_t)desc->base3 << 32) |
-		(desc->base0 | ((desc->base1) << 16) | ((desc->base2) << 24));
+	uint64_t low = (uint64_t)desc->base0 |
+		       ((uint64_t)desc->base1 << 16) |
+		       ((uint64_t)desc->base2 << 24);
+
+	return (uint64_t)desc->base3 << 32 | low;
 }
 
 static inline uint64_t rdtsc(void)
-- 
2.52.0


